//
//  Journey.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Journey: View {
    @EnvironmentObject var userData: UserData
    @State private var newEventData = JourneyEvent.Data()
    @State private var isPresented = false
    
    var events: [JourneyEvent] {
        userData.userJourneyEvents.reversed()
    }
    
    var eventsIndices: [Int] {
        Array(events.indices)
    }
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    VStack {
                        
                        NavigationLink(destination: EmptyView()) {
                            ZStack {
                                
                                Circle()
                                    .strokeBorder(Color("AppColor1"))
                                    .background(Circle().fill(Color("AppColor1")))
                                    .frame(width: 180, height: 180)
                                
                                VStack(spacing: 10) {
                                    HStack(alignment: .top, spacing: -15) {
                                        
                                        Image(systemName: "flag")
                                            .font(.system(size: 50))
                                        
                                        Image(systemName: "plus.circle")
                                            .font(.system(size: 20))
                                            .background(Color("AppColor1"))
                                            .mask(Circle())
                                        
                                    }
                                    
                                    Text("Aujourd'hui")
                                        .font(.title3)
                                }
                                
                            }
                            .padding()
//                            .navigationBarItems(trailing: Button(action: {
//                                isPresented = true
//                            }) {
//                                Image(systemName: "plus")
//                            })
//                            .sheet(isPresented: $isPresented) {
//                                JourneyEdit()
//                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    
                    VStack(spacing: 0) {
                        ForEach(eventsIndices, id: \.self) { index in
                            
                            let event = events[index]
                            let previousMood = events[max(0, index - 1)].moodValue
                            let realIndex = (events.count - 1) - index
                            
                            NavigationLink(destination: JourneyDetail(event: $userData.userJourneyEvents[realIndex])) {
                                JourneyCell(previousMoodValue: previousMood, event: event, pickedImage: $userData.userJourneyEvents[realIndex].image)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    
                    VStack(spacing: 10) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color("AppColor3"))
                        
                        Text("Début")
                            .foregroundColor(Color("AppColor3"))
                    }
                    .padding()
                    
                }
                .padding(.vertical)
                .navigationTitle("Parcours")
            }
            
        }
    }
}

// permet de construire une vue à partir de laquelle l'utilisateur peut voir sa librairie de photos et en choisir une
struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // classe qui permet de gérer la sélection de l'image
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @StateObject var vm = FileManagerViewModel()
        
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        // fonction qui détermine ce qu'il se passe quand l'utilisateur sélectionne une image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                print(selectedImageFromPicker)
                self.parent.selectedImage = selectedImageFromPicker
            }
            self.parent.isPresented = false
        }
        
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
    
}

// tiré du tuto pour faire persister une image des assets vers FileManager
class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        
        // permet de réduire la qualité de l'image
        guard
            let data = image.jpegData(compressionQuality: 0.5),
            let path = getPathForImage(name: name) else {
            print("Error getting data.")
            return
        }
        
        
        do {
            try data.write(to: path)
            print("Success saving!")
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
        
    }
    
    func getPathForImage(name: String) -> URL? {
        
        guard
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name).jpg") else {
            print("Error getting path.")
            return nil
        }
        
        return path
        
    }
    
    func getPathForJson(name: String) -> URL? {
        
        guard
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name).json") else {
            print("Error getting path.")
            return nil
        }
        
        return path
        
    }
    
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    @State private var imageName: String = ""
    
    let manager = LocalFileManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        manager.saveImage(image: image, name: imageName)
    }
    
}


struct Journey_Previews: PreviewProvider {
    
    static var previews: some View {
        Journey().environmentObject(UserData(name: "Albert", userElementsList: MYELEMENTS, userJourneyEvents: MYJOURNEY, userMoodHistory: MYMOODS))
            .environment(\.locale, Locale(identifier: "fr"))
    }
    
}

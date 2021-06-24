//
//  Journey.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Journey: View {
    @EnvironmentObject var userData: UserData
    @State private var isPresented = false
    @State private var isEdited = false
    @State private var newEventData = JourneyEvent.Data()
    @State private var shownImageNew = UIImage()
    @State private var newEvent = JourneyEvent(title: "", date: Date(), imageName: UUID().uuidString, type: 0, moodValue: 5, comment: "")
    
    var events: [JourneyEvent] {
        return userData.userJourneyEvents.sorted {
            $0.date > $1.date
        }
    }
    
    var eventsIndices: [Int] {
        Array(events.indices)
    }
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 2, height: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("AppColor1"))
                        .shadow(color: Color("AppColor1").opacity(0.9), radius: 3)
                        .padding(.leading, -5.5)
                    
                    VStack{
                        Color("AppColor3").frame(height:270)
                        Spacer()
                    }
                    
                    VStack{
                        Spacer().frame(width: 1, height: 304, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        HStack{
                            Circle()
                                .foregroundColor(Color(#colorLiteral(red: 0.682051599, green: 0.8307157159, blue: 0, alpha: 1)))
                                .frame(width:10, height:10)
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    VStack(spacing:0) {
                        //top
                        VStack{
                            
                            Button(action: {
                                isEdited = true
                            }, label: {
                                ZStack{
                                    Circle()
                                        .fill(Color("AppColor1"))
                                        .shadow(color: Color.red.opacity(0.2),
                                                radius: 5,
                                                x: 7,
                                                y: 7)
                                        .shadow(color: Color.white.opacity(0.3),
                                                radius: 5,
                                                x: -5,
                                                y: -5)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 0.3)
                                        )
                                    VStack{
                                        Text("Nouveau palier").foregroundColor(Color("AppColorWhite"))
                                            .padding(.bottom, 10)
                                        Image(systemName: "flag")
                                            .font(.system(size: 60))
                                            .foregroundColor(Color("AppColorWhite"))
                                            
                                    }.frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }
                            }) .buttonStyle(PlainButtonStyle())
                            .fullScreenCover(isPresented: $isEdited) {
                                NavigationView {
                                    JourneyEdit(event: newEvent, JourneyData: $newEventData, pickedImage: $shownImageNew)
                                        .navigationBarItems(leading: Button("Annuler") {
                                            isEdited = false
                                        }, trailing: Button("Terminé") {
                                            isEdited = false
                                            newEvent.update(from: newEventData)
                                            userData.userJourneyEvents.append(newEvent)
                                            userData.writeJson(tab: userData.userJourneyEvents, filename: "JourneyList")
                                        })
                                }
                                
                            }
                            
                        }.padding(.top, 70)
                        .padding(.bottom, 40)
                        
                        
                        //events
                        VStack(spacing: 0) {
                            ForEach(eventsIndices, id: \.self) { index in
                                
                                let event = events[index]
                                let previousMood = events[max(0, index - 1)].moodValue
                                let realIndex: Int? = userData.userJourneyEvents.firstIndex(of: event)
                                
                                NavigationLink(destination: JourneyDetail(event: $userData.userJourneyEvents[realIndex!])) {
                                    JourneyCell(previousMoodValue: previousMood, event: event, pickedImage: $userData.userJourneyEvents[realIndex!].image)
                                        .shadow(color: Color.white.opacity(0.25),
                                                                                                                                                                  radius: 5,
                                                                                                                                                                  x: -5,
                                                                                                                                                                  y: -5)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        //début
                        VStack(spacing: 10) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color("AppColor1"))
                                .shadow(color: Color("AppColor1").opacity(0.8), radius: 3)
                                .padding(.top, -2)
                            
                            Text("Votre début avec Bonum")
                                .foregroundColor(Color("AppColor2"))
                        }
                        .padding(.leading, -10)
                        .background(Color("AppColor3"))
                        .padding(.top, 50)
                        
                    }
                }
                .padding(.bottom, 80)
            }.navigationBarHidden(true)
            .navigationTitle("Parcours")
            .edgesIgnoringSafeArea(.all)
            .background(Color("AppColor3"))
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
            
            print(path)
            print("Success saving!")
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path for image \(name).")
            return nil
        }
        
        print(path)
        return UIImage(contentsOfFile: path)
        
    }
    
    func getPathForImage(name: String) -> URL? {
        
        guard
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name).jpg") else {
            print("Error getting path for image \(name).")
            return nil
        }
        
        return path
        
    }
    
    func getPathForJson(name: String) -> URL? {
        
        guard
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name).json") else {
            print("Error getting path for Json \(name).")
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

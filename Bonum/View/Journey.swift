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
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                List {
                    ForEach(userData.userJourneyEvents, id: \.self) { event in
                        
                        NavigationLink(destination: JourneyDetail(event: event)) {
                            JourneyCell(event: event)
                        }
                        
                    }
                }
                .listStyle(PlainListStyle())
                
            }
            .navigationTitle("Parcours")
            .navigationBarItems(trailing: Button(action: {
                isPresented = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isPresented) {
                JourneyEdit()
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
    }
    
}

//
//  Journey.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

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
    
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "salle-sport"
    let manager = LocalFileManager.instance
    
    init() {
        getImageFromAssetsFolder()
        //        getImageFromFileManager()
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

struct TestsFileManager: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        
        VStack {
            
            if let image = vm.image {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(10)
                
            }
            
            Button(action: {
                vm.saveImage()
            }, label: {
                Text("Save to FM")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            
        }
    }
    
}

struct Journey: View {
    
    @State var isShowingImagePicker = false
    
    @State var shownImage = UIImage()
    
    let events: [JourneyEvent]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            List {
                ForEach(events, id: \.self) { event in
                    
                    HStack(spacing: 20) {
                        
                        Text("Date")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Button(action: {
                            self.isShowingImagePicker.toggle()
                        }, label: {
                            
                            Image(uiImage: shownImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray))
                            
                        })
                        .sheet(isPresented: $isShowingImagePicker, content: {
                            ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: self.$shownImage)
                        })
                        
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            Text("Nom de la nouvelle donnée suivie")
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                        
                    }
                    
                }
                
                
                .padding()
            }
            
        }
        
    }
    
}



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
        
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
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


struct Journey_Previews: PreviewProvider {
    static var previews: some View {
        Journey(events: JourneyEvent.events)
    }
}

struct TestsFileManager_Previews: PreviewProvider {
    static var previews: some View {
        TestsFileManager()
    }
}

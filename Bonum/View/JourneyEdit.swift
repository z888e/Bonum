//
//  JourneyEdit.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 18/06/2021.
//

import SwiftUI

struct JourneyEdit: View {
    
    let event: JourneyEvent
    @Binding var JourneyData: JourneyEvent.Data
    
    @State private var isShowingImagePicker = false
    @State private var shownImage = UIImage()
    @Binding var pickedImage: UIImage
    
    var imageName: String {
        return event.imageName.isEmpty ? UUID().uuidString : event.imageName
    }
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                self.isShowingImagePicker.toggle()
            }, label: {
                
                ZStack {
                    
                    Image(uiImage: shownImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray))
                        .padding(.horizontal)
                    
                    Text("Modifier")
                        .font(.subheadline)
//                    Text(imageName)
                }
                
            })
            .sheet(isPresented: $isShowingImagePicker, content: {
                ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: self.$pickedImage)
            })
            .onChange(of: pickedImage, perform: { value in
                LocalFileManager.instance.saveImage(image: value, name: imageName)
                shownImage = pickedImage
            })
            .onAppear(perform: {
                shownImage = LocalFileManager.instance.getImage(name: imageName) ?? UIImage()
            })
            
            List {

                TextField("Titre", text: $JourneyData.title)
                DatePicker("Date", selection: $JourneyData.date, displayedComponents: .date)
                TextField("Commentaire", text: $JourneyData.comment)
                
            }
            .listStyle(InsetGroupedListStyle())
        }

        
    }
    
}

struct JourneyEdit_Previews: PreviewProvider {
    static var previews: some View {
        JourneyEdit(event: MYJOURNEY[0], JourneyData: .constant(MYJOURNEY[0].data), pickedImage: .constant(UIImage()))
    }
}

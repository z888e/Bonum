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
    @State private var pickedImage = UIImage()
    
    var body: some View {
        
        VStack {
            
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
                ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: self.$pickedImage)
            })
            .onChange(of: pickedImage, perform: { value in
                LocalFileManager.instance.saveImage(image: value, name: event.imageName)
                shownImage = pickedImage
            })
            .onAppear(perform: {
                shownImage = LocalFileManager.instance.getImage(name: event.imageName) ?? UIImage()
            })
            
            List {

                TextField("Titre", text: $JourneyData.title)
                DatePicker("Date", selection: $JourneyData.date)
                
            }
            .listStyle(InsetGroupedListStyle())
        }

        
    }
    
}

struct JourneyEdit_Previews: PreviewProvider {
    static var previews: some View {
        JourneyEdit(event: MYJOURNEY[0], JourneyData: .constant(MYJOURNEY[0].data))
    }
}

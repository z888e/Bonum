//
//  JourneyCell.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 16/06/2021.
//

import SwiftUI

struct JourneyCell: View {
    
    let event: JourneyEvent
    
    @State var isShowingImagePicker = false
    @State var shownImage = UIImage()
    
    var body: some View {
        
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
        .padding()
    }
}


struct JourneyCell_Previews: PreviewProvider {
    static var event = JourneyEvent.events[0]
    static var previews: some View {
        JourneyCell(event: event)
            .previewLayout(.sizeThatFits)
    }
}

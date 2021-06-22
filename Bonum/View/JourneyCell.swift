//
//  JourneyCell.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 16/06/2021.
//

import SwiftUI

struct JourneyCell: View {
    
    let previousMoodValue: Int
    let event: JourneyEvent
    
    var currentMoodColor: Color {
        ratingColorMapping[event.moodValue] ?? .purple
    }
    var previousMoodColor: Color {
        ratingColorMapping[previousMoodValue] ?? .purple
    }
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [previousMoodColor, currentMoodColor]), startPoint: .top, endPoint: .bottom)
    }
    
    @State private var isShowingImagePicker = false
    @State private var shownImage = UIImage()
    @Binding var pickedImage: UIImage
    
    var body: some View {
        
        HStack {
            
            Rectangle()
                .fill(gradient)
                .frame(width: 10, height: 150)
            
            Spacer()
            
            VStack {
                
                Image(systemName: "arrow.up")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                
                HStack {
                    
                    Text("\(event.date, style: .date)")
                        .fontWeight(.semibold)
                        .font(.caption)
                    
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
                    
                    VStack(alignment: .leading) {
                        Text(event.title)
                            .font(.callout)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                        Text("Nom de la nouvelle donnée suivie")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                }
                
            }
            
            Spacer()
            
        }
    }
}


struct JourneyCell_Previews: PreviewProvider {
    static var previews: some View {
        JourneyCell(previousMoodValue: 5, event: MYJOURNEY[0], pickedImage: .constant(UIImage()))
            .previewLayout(.sizeThatFits)
            .environment(\.locale, Locale(identifier: "fr"))
    }
}

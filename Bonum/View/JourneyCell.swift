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
    let ratingColorMapping = [
        0: Color(#colorLiteral(red: 1, green: 0.1863677502, blue: 0.05024763197, alpha: 1)),
        1: Color(#colorLiteral(red: 1, green: 0.3130919337, blue: 0, alpha: 1)),
        2: Color(#colorLiteral(red: 0.9529370666, green: 0.4147374034, blue: 0, alpha: 1)),
        3: Color(#colorLiteral(red: 1, green: 0.5982946157, blue: 0, alpha: 1)),
        4: Color(#colorLiteral(red: 0.9715039134, green: 0.6631778479, blue: 0, alpha: 1)),
        5: Color(#colorLiteral(red: 1, green: 0.8351451755, blue: 0, alpha: 1)),
        6: Color(#colorLiteral(red: 0.8309281468, green: 0.8181648254, blue: 0, alpha: 1)),
        7: Color(#colorLiteral(red: 0.682051599, green: 0.8307157159, blue: 0, alpha: 1)),
        8: Color(#colorLiteral(red: 0.4331716299, green: 0.7751298547, blue: 0, alpha: 1)),
        9: Color(#colorLiteral(red: 0.231847465, green: 0.7812655568, blue: 0.109912999, alpha: 1)),
        10: Color(#colorLiteral(red: 0, green: 0.7668917179, blue: 0.2233996391, alpha: 1))
    ]
    
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

//
//  JourneyCell.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 16/06/2021.
//

import SwiftUI

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

struct JourneyCell: View {
    
    var asImageChanged: Bool = false
    
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
        
        ZStack {
            HStack{
            Rectangle()
                .fill(gradient)
                .frame(width: 10)
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("AppColorWhite"))
                .frame(width: .infinity, height: 110, alignment: .center)
                .addBorder(Color("AppColor1"), width: 1, cornerRadius: 25)
                .padding()
                
            VStack{
//                HStack{
//                    Spacer()
//                    Image(systemName: "chevron.up")
//                        .font(.system(size: 15))
//                        .foregroundColor(Color("AppColor1"))
//                        .shadow(color: Color("AppColor1").opacity(0.5), radius: 3)
//                        .padding(.bottom, 20)
//                    Spacer()
//                }.padding(.leading, -10)
            
            HStack {
             
                HStack {
                Spacer()
                Text(dateToString(date: event.date, format: "Date"))
                    .font(.system(size: 13))
                }
                    
                    Button(action: {
                        self.isShowingImagePicker.toggle()
                    }, label: {
                        
                        Image(uiImage: shownImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("AppColor2").opacity(0.2)))
                            .padding(.horizontal)
                    })
                    .sheet(isPresented: $isShowingImagePicker, content: {
                        ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: self.$pickedImage)
                    })
                    .onChange(of: pickedImage, perform: { value in
                        print("onchange pickedImage")
                        LocalFileManager.instance.saveImage(image: value, name: event.imageName)
                        shownImage = pickedImage
                    })
                    .onAppear(perform: {
                        shownImage = LocalFileManager.instance.getImage(name: event.imageName) ?? UIImage()
                    })
//                    .onChange(of: asImageChanged, perform: { value in
//                        print("onchange asImageChanged")
//                        shownImage = LocalFileManager.instance.getImage(name: event.imageName) ?? UIImage()
//                    })
                
                HStack{
                    VStack(alignment: .leading) {
                    Text(event.title)
                        .font(.body)
                        .foregroundColor(Color("AppColor2"))
//                        .fontWeight(.semibold)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 17))
//                    Text("Nom de la nouvelle donnée suivie")
//                        .foregroundColor(Color("AppColor2"))
//                        .font(.caption)
//                        .multilineTextAlignment(.leading)
                }
                    Spacer()
                }
//                .frame(maxWidth: .infinity)
                
            }.padding(.vertical, 10)
            .padding(.leading, -10)
            }
            .padding(37)
        }
    }
    
}


struct JourneyCell_Previews: PreviewProvider {
    static var previews: some View {
        JourneyCell(previousMoodValue: 5, event: MYJOURNEY[3], pickedImage: .constant(UIImage()))
            .previewLayout(.sizeThatFits)
            .environment(\.locale, Locale(identifier: "fr"))
    }
}

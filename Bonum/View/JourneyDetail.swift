//
//  JourneyDetail.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct JourneyDetail: View {
    
    var event: JourneyEvent
    @State private var journeyData: JourneyEvent.Data = JourneyEvent.Data()
    @State private var shownImage = UIImage()
    @State private var pickedImage = UIImage()
    @State private var isPresented = false
    
    var body: some View {
        
        VStack {
            
            Image(uiImage: shownImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    Text("\(event.title)\n\(event.date, style: .date)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.black))
                        .cornerRadius(10)
                        .opacity(0.8)
                        .padding(),
                    
                    alignment: .top
                )

                .onAppear(perform: {
                    shownImage = LocalFileManager.instance.getImage(name: event.imageName) ?? UIImage()
                })
                .onChange(of: pickedImage, perform: { value in
                    LocalFileManager.instance.saveImage(image: value, name: event.imageName)
                    shownImage = pickedImage
                })
            
            Spacer()
            
        }
        .navigationBarItems(trailing: Button("Modifier"){
            isPresented = true
        })
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                JourneyEdit(event: event, JourneyData: $journeyData)
                    .navigationTitle(event.title)
                    .navigationBarItems(leading: Button("Annuler") {
                        isPresented = false
                    }, trailing: Button("Terminé") {
                        isPresented = false
//                        event.update(from: journeyData)
                    })
            }
        }
        
    }
    
}

struct JourneyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JourneyDetail(event: MYJOURNEY[0])
                .environment(\.locale, Locale(identifier: "fr"))
        }
    }
}

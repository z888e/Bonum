//
//  JourneyDetail.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct JourneyDetail: View {
    
    @EnvironmentObject var userData: UserData
    @Binding var event: JourneyEvent
    @State private var journeyData: JourneyEvent.Data = JourneyEvent.Data()
    @State private var shownImage = UIImage()
    @State private var isPresented = false
    
    var eventDate: String {
        let date = event.date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr")
        formatter.setLocalizedDateFormatFromTemplate("dMMMMYYYY")
        return formatter.string(from: date)
    }
    
    var body: some View {
        
        VStack {

            Image(uiImage: shownImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    Text("\(event.title)\n\(eventDate)\n\n\(event.comment)")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("AppColorWhite"))
                        .padding()
                        .frame(width: 300, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color("AppColor3"))
                        .cornerRadius(25)
                        .opacity(0.9)
                        .padding(),
                    alignment: .top
                )

                .onAppear(perform: {
                    journeyData = event.data
                    shownImage = LocalFileManager.instance.getImage(name: event.imageName) ?? UIImage()
                })
                .onChange(of: event.image, perform: { value in
                    LocalFileManager.instance.saveImage(image: value, name: event.imageName)
                    shownImage = event.image
                })
                        
        }
        .navigationBarItems(trailing: Button("Modifier"){
            isPresented = true
        })
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                JourneyEdit(event: event, JourneyData: $journeyData, pickedImage: $event.image)
                    .navigationBarItems(leading: Button("Annuler") {
                        isPresented = false
                    }, trailing: Button("Terminé") {
                        isPresented = false
                        event.update(from: journeyData)
                        userData.writeJson(tab: userData.userJourneyEvents, filename: "JourneyList")
                    })
            }
        }
        
    }
    
}

struct JourneyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JourneyDetail(event: .constant(MYJOURNEY[0]))
                .environment(\.locale, Locale(identifier: "fr"))
        }
    }
}

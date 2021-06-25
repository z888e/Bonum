//
//  ScoreBonumDetails.swift
//  Bonum
//
//  Created by Zoé Hartman on 23/06/2021.
//

import SwiftUI

struct ScoreBonumDetails: View {
    
    @EnvironmentObject var userData : UserData
    
    var sortedMoodHistory: [MoodValue] {
        return userData.userMoodHistory.sorted {
            $0.timestamp > $1.timestamp
        }
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left")
                .foregroundColor(Color("AppColor3"))
            Text("Journal")
                .foregroundColor(Color("AppColor3"))
        }
    }
    }
    var body: some View {
        VStack{
            HStack{
                btnBack.padding(20).padding(.top, 40)
                Spacer()
            }.background(Color("AppColorWhite"))
            
            Text("Historique de votre score Bonum").foregroundColor(Color("AppColor2"))
                .padding(.vertical, 30)
            
            ScrollView {
                ForEach(sortedMoodHistory, id: \.self) { moodEntry in
                    MoodCell(mood: moodEntry)
                }
            }
        }.background(Color("AppColorWhite"))
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
}

struct ScoreBonumDetails_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBonumDetails()
    }
}

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
    
    var body: some View {
        VStack{
            ScrollView {
                ForEach(sortedMoodHistory, id: \.self) { moodEntry in
                    MoodCell(mood: moodEntry)
                }
            }
        }.background(Color("AppColorWhite"))
    }
}

struct ScoreBonumDetails_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBonumDetails()
    }
}

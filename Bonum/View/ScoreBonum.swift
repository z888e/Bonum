//
//  ScoreBonum.swift
//  Bonum
//
//  Created by Zoé Hartman on 17/06/2021.
//

import SwiftUI

struct ScoreBonum: View {
    
    @EnvironmentObject var userData: UserData

    var timeArea : String
    
    var lastMood: Int {
           userData.userMoodHistory.last?.rating ?? 0
        }
    
//    var last7daysAvgMood
//    var last30daysAvgMood
//    var last365DaysAvgMood

    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 200, height: 200)
            VStack(spacing: 10){
                Text("Score Bonum").font(.system(size: 20.0))
                if lastMood == 0 {
                    Text("").font(.system(size: 20.0))
                } else {
                    Text(String(lastMood)).font(.system(size: 60.0))
                }
            }.foregroundColor(.white).shadow(radius: 1)
        }
    }
}

struct ScoreBonum_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBonum(timeArea: "J")
    }
}

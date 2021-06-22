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
    
    var last7days: [Int]{userData.userMoodHistory.suffix(7).map{$0.rating}}
    var last7daysAvgMood : Double{Double(last7days.reduce(0, +)) / Double(last7days.count)}
    
    var last30days: [Int]{userData.userMoodHistory.suffix(30).map{$0.rating}}
    var last30daysAvgMood : Double{Double(last30days.reduce(0, +)) / Double(last30days.count)}

    var last365days: [Int]{userData.userMoodHistory.suffix(365).map{$0.rating}}
    var last365daysAvgMood : Double{Double(last365days.reduce(0, +)) / Double(last365days.count)}


    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 200, height: 200)
            VStack(spacing: 10){
                Text("Score Bonum").font(.system(size: 20.0))
                if timeArea == "J" {
                    Text(String(lastMood)).font(.system(size: 60.0))
                }
                if timeArea == "S" {
                    Text("\(last7daysAvgMood, specifier: "%.1f")").font(.system(size: 60.0))
                }
                if timeArea == "M" {
                    Text("\(last30daysAvgMood, specifier: "%.1f")").font(.system(size: 60.0))
                }
                if timeArea == "A" {
                    Text("\(last365daysAvgMood, specifier: "%.1f")").font(.system(size: 60.0))
                }
//                Button(action: {
//                    print(last7days)
//                }, label: {
//                    Text("test")
//                })
            }.foregroundColor(.white).shadow(radius: 1)
        }
    }
}

struct ScoreBonum_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBonum(timeArea: "J")
    }
}

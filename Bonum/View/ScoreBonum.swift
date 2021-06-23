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
    
    let gradient = RadialGradient(
        gradient   : Gradient(colors: [.yellow, .red]),
        center     : UnitPoint(x: 0.25, y: 0.25),
        startRadius: 0.2,
        endRadius  : 200
    )
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        NavigationLink(
            destination: ScoreBonumDetails(),
            label: {
                ZStack{
                    Circle()
                        .fill(Color("AppColor1"))
                        .shadow(color: Color.red.opacity(0.2),
                                radius: 5,
                                x: 7,
                                y: 7)
                        .shadow(color: Color.white.opacity(0.3),
                                radius: 5,
                                x: -5,
                                y: -5)
                        .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 0.3)
                        )
//                    Circle()
//                        .fill(
//                            LinearGradient(gradient: Gradient(colors: [.yellow, Color("AppColor1")]), startPoint: .topTrailing, endPoint: .leading)
//                            )
        //                .strokeBorder(
        //                    AngularGradient(gradient: Gradient(colors: [.red, .green, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)),
        //                    lineWidth: 5
        //                    )
        //                .foregroundColor(Color("AppColor1"))
        //                .strokeBorder(Color("AppColor1"),lineWidth: 1)
        //                .background(Circle().foregroundColor(Color("AppColor1")))
        //                                        }.padding().frame(height: 300)
                        .frame(width: 200, height: 200)
                        .shadow(color: Color("AppColor1").opacity(0.8), radius: 3)
                    
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
                    }.foregroundColor(Color("AppColorWhite"))
                }
            }
        )
    }
}

struct ScoreBonum_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBonum(timeArea: "J")
    }
}

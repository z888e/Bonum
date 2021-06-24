//
//  DiaryListCell.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryListCell: View {
    
    let element : DataElement
    
    var impactLevel : Int{
        var res:Int = 0
        if element.impact > 0 && element.impact <= 1{
            res = 1
        }
        if element.impact > 1 && element.impact <= 2{
            res = 2
        }
        if element.impact > 2 && element.impact <= 3{
            res = 3
        }
        return res
    }
    
    
    var timeArea : String
    var lastDailyValue : Double{element.values.last?.value ?? 0.0}
    var last7daysOfEl: [Double]{element.values.suffix(7).map{$0.value}}
    var last7daysAvgValueOfEl : Double{Double(last7daysOfEl.reduce(0, +)) / Double(last7daysOfEl.count)}
    var last7daysTotalValueOfEl : Double{last7daysOfEl.reduce(0, +)}

    var elValueDisplayed : Double {
        var res = 0.0
        if timeArea == "J" {
            res = lastDailyValue
        }
        if element.isDiscrete {
            if timeArea == "S" {
                res = last7daysAvgValueOfEl
            }
        }
        if !element.isDiscrete {
            if timeArea == "S" {
                res = last7daysTotalValueOfEl
            }
        }
        return res
    }
    
    var timeAreaComment : String {
        var res = " "
        if timeArea != "J" {
            if element.isDiscrete {
                res = "en moyenne"
            }
            if !element.isDiscrete {
                res = "au total"
            }
        }
        return res
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                HStack(spacing:7){
                    ImpactIllustration(impactLevel : impactLevel).padding(.bottom, 10)
                        .foregroundColor(Color("AppColor2"))
                    Text(element.customName).foregroundColor(Color("AppColor2"))
                }.padding(0)
                                
                HStack{
                    if lastDailyValue == 0 {
                        Text("Pas de donnée aujourd'hui").italic()
                            .foregroundColor(Color("AppColor2"))
                    } else {
                        HStack(alignment: .bottom){
                            Text("\(elValueDisplayed, specifier: element.displayedSpecifier)").font(.system(size: 30.0))
                                .foregroundColor(Color("AppColor2"))
                            Text("\(element.displayedUnit)")
                                .foregroundColor(Color("AppColor2"))
                            Text("\(timeAreaComment)")
                                .foregroundColor(Color("AppColor1"))
                                .italic()
                        }
                    }
                }
            }
            Spacer()
        }.padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("AppColor1"), lineWidth: 1).shadow(color: Color("AppColor1"), radius: 2.5, x: -2, y: 2)
        )
    }
}

struct DiaryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListCell(element: MYSTEPSELEMENT, timeArea: "S")
    }
}

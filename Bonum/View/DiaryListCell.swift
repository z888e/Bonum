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
    
    var lastDailyValue : Double{element.values.last?.value ?? 0.0}
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                HStack(spacing:7){
                    ImpactIllustration(impactLevel : impactLevel).padding(.bottom, 10)
                    Text(element.customName)
                }.padding(5)
                
                Spacer()
                
                HStack{
                    if lastDailyValue == 0 {
                        Text("Pas de donnée aujourd'hui")
                    } else {
                        HStack{
                            Text("\(lastDailyValue, specifier: element.displayedSpecifier)").font(.system(size: 30.0))
                            Text("\(element.displayedUnit)")
                        }
                    }
                }
            }
            Spacer()
        }.padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("AppColor1"), lineWidth: 1).shadow(color: Color("AppColor1"), radius: 3.0, x: -2, y: 2)
        )
    }
}

struct DiaryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListCell(element: MYSTEPSELEMENT)
    }
}

//
//  DiaryListCell.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryListCell: View {
    
    let element : DataElement
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text(element.customName)
                Text("impact niveau " + String(element.impact))
                Spacer()
            }
            Spacer()
        }.padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1).shadow(radius: 1.0)
        )
    }
}

struct DiaryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListCell(element: MYSTEPSELEMENT)
    }
}

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
        VStack{
//            Text("\(element[0].count, specifier: "%.0f")")
//            Text(element[0].count, style: .date)
//                .opacity(0.5)
            Text(element.customName)
        }
        
    }
}

struct DiaryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListCell(element: MYSTEPSELEMENT)
    }
}

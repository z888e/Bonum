//
//  DiaryListCell.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryListCell: View {
    
    let displayedData : DataValue
    
    var body: some View {
        VStack{
            Text("\(displayedData.count)")
            Text(displayedData.date, style: .date)
                .opacity(0.5)
        }
        
    }
}

struct DiaryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListCell(displayedData: MYSTEPS[1])
    }
}

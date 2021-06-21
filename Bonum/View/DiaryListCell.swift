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
        VStack(alignment: .leading, spacing: 10){
            Text(element.customName)
            Text(element.identifierInHK)
            Text("impact niveau" + String(element.impact))
        }
    }
}

struct DiaryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListCell(element: MYSTEPSELEMENT)
    }
}

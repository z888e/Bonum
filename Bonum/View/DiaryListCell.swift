//
//  DiaryListCell.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryListCell: View {
    
    @Binding var steps : [DataValue]

    var body: some View {
        Text("Hello, World!")
    }
}

struct DiaryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListCell(steps: .constant(MYSTEPS))
    }
}

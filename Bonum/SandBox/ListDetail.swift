//
//  ListDetail.swift
//  Bonum
//
//  Created by Wilfried Roguet on 14/06/2021.
//
// Thomas

import SwiftUI

struct ListDetail: View {
    let imageName: String
    let textToDDisplay: String
    
    var body: some View {
        HStack{
            Image(systemName: imageName)
        Text(textToDDisplay)
    }
    }
}

struct ListDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListDetail(imageName: "point", textToDDisplay: "Hello team")
    }
}

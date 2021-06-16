//
//  ListDetail.swift
//  Bonum
//
//  Created by Wilfried Roguet on 14/06/2021.
//

import SwiftUI

struct WilListDetail: View {
    let imageName: String
    let textToDDisplay: String
    
    var body: some View {
        HStack{
            Image(systemName: imageName)
        Text(textToDDisplay)
    }
    }
}

struct WilListDetail_Previews: PreviewProvider {
    static var previews: some View {
        WilListDetail(imageName: "play", textToDDisplay: "Hello team")
    }
}

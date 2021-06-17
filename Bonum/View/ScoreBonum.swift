//
//  ScoreBonum.swift
//  Bonum
//
//  Created by Zoé Hartman on 17/06/2021.
//

import SwiftUI

struct ScoreBonum: View {
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 200, height: 200)
            Text("Score Ici")
        }
    }
}

struct ScoreBonum_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBonum()
    }
}

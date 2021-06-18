//
//  MoodCell.swift
//  Bonum
//
//  Created by Wilfried Roguet on 18/06/2021.
//

import SwiftUI

struct MoodCell: View {
    let mood: MoodValue
    var moodRating: Double{
        return Double(mood.rating ?? 0)
    }


    var body: some View {
        ZStack{
            Color(red: 0, green: moodRating*25/255, blue: 0)
        HStack{
            Text(String(moodRating))
            Spacer()
        Text(mood.timestamp, style: .date)
    }
        .padding()
    }
    }
}

struct MoodCell_Previews: PreviewProvider {
    static var previews: some View {
        MoodCell(mood: MYMOODS[4])
    }
}

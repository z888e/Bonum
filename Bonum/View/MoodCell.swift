//
//  MoodCell.swift
//  Bonum
//
//  Created by Wilfried Roguet on 18/06/2021.
//

import SwiftUI

struct MoodCell: View {
    let mood: MoodValue
    var moodRating: Int{
        return mood.rating ?? 0
    }
    
    var body: some View {
        ZStack{
            //            Color(red:  255/(Double(moodRating)*150), green: 0.5, blue: 0)
            //                .opacity(0.8)
            ratingColorMapping[moodRating]
            HStack{
                Text(String(moodRating))
                    .fontWeight(.bold)
                Spacer()
                Text("\(dateToString(date: mood.timestamp))")
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
        }
    }
}

struct MoodCell_Previews: PreviewProvider {
    static var previews: some View {
        MoodCell(mood: MYMOODS[4])
    }
}

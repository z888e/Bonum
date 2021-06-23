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
        //        return mood.rating ?? 0
                return mood.rating
    }
    
    var body: some View {
        ZStack{
//            ratingColorMapping[moodRating]
            HStack{
                Text("\(dateToString(date: mood.timestamp, format: "DateTimeShort"))")
                        .font(.system(size: 12))
                Spacer()
                MiniSquare(rate: moodRating)
            }
            .padding( EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30) )
        }
    }
}

struct MiniSquare: View {
    let rate:Int
    
    var body: some View {
        Text("\(rate)")
            .fontWeight(.bold)
            .font(.system(size: 12))
            .foregroundColor(Color("AppColorWhite"))
            .frame(width: 20, height: 20, alignment: .center)
            .background(ratingColorMapping[rate])
            .cornerRadius(6)
    }
}

struct MoodCell_Previews: PreviewProvider {
    static var previews: some View {
        MoodCell(mood: MYMOODS[4])
            .previewLayout(.sizeThatFits)
    }
}

//
//  Mood.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import Foundation

struct Mood {
    
    var timestamp: Date
    var rating: Int? // si c'est nil, c'est joker
    var source: Int // widget, bouton ? tab view, notification
}

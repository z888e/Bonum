//
//  TrackedData.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import Foundation

struct beginEnd {
    var begin: Date
    var end: Date?
}

struct TrackedData {
    
    // identifiant HK, cumulative ?
    
    var customName: String?
    var periods: [beginEnd] // périodes sur lesquelles on suit la donnée
    var impact: Int // impact calculé de cette donnée sur la forme
    
}

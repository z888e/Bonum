//
//  TrackedDataValue.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import Foundation

struct DataValue: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

let MYSTEPS : [DataValue] = [
    DataValue(count: 1845, date: Date()),
    DataValue(count: 54, date: Date() - 1000),
]

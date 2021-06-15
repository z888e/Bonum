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
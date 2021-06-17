////
////  TrackedData.swift
////  Bonum
////
////  Created by Alexandre Dias Da Silva on 11/06/2021.
////
//
//import Foundation
//
//func startDateFormatter(year y:Int, month m:Int, day d:Int) -> Date {
//    let calendar = Calendar.current
//    let dateComponents = DateComponents(calendar: calendar,
//                                        year: y,
//                                        month: m,
//                                        day: d)
//    let date = calendar.date(from: dateComponents)!
//    return date
//}
//
//struct TrackedData {
//    
//    var identifierInHK : String
//    var customName: String
//    var begin: Date
//    var end: Date?
//    var impact: Int // impact calculé de cette donnée sur la forme
//    var values : [DataValue]
//}
//
////DONNEES TEST
//
//let MYSTEPSVARIABLE = TrackedData (
//    identifierInHK: "stepCount",
//    customName: "Pas à pas",
//    begin: startDateFormatter(year: 2021, month: 06, day: 10),
//    impact: 1,
//    values: MYSTEPS
//)
//
//let MYVARIABLES: [TrackedData] = [MYSTEPSVARIABLE]
//

//
//  UserData.swift
//  Bonum
//
//  Created by Zoé Hartman on 16/06/2021.
//

import Foundation
import HealthKit


func startDateFormatter(year y:Int, month m:Int, day d:Int) -> Date {
    let calendar = Calendar.current
    let dateComponents = DateComponents(calendar: calendar,
                                        year: y,
                                        month: m,
                                        day: d)
    let date = calendar.date(from: dateComponents)!
    return date
}

struct DataValue: Identifiable {
    let id = UUID()
    let count: Double
    let date: Date
}

struct DataElement : Identifiable {
    
    var id = UUID()
    var identifierInHK : String
    var customName: String
    var begin: Date
    var end: Date?
    var impact: Int // impact calculé de cette donnée sur la forme
    var values : [DataValue]
}

let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())
let endDate = Date()

class UserData: ObservableObject {
    var name : String
    var userElementsList = [DataElement]()
    
    var healthStore: HKHealthStore?
    var collectionQuery: HKStatisticsCollectionQuery?
    
    init(name: String, userElementsList: [DataElement]) {
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()
        }
        self.name = name
        self.userElementsList = userElementsList
    }
    
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        //selectionne stepCount
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        //anchorDate, moment où le .comp commence
        //creer calendrier
        let calendar = NSCalendar.current
        //définir l'unité de temps voulue
        //creer comp dates
        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
        //se placer lundi
        let offset = (7 + anchorComponents.weekday! - 2) % 7
        anchorComponents.day! -= offset
        //à 2h matin
        anchorComponents.hour = 2
        //générer l'anchor date, utilisée comme ref
        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
            fatalError("*** Unable to create valid Date from the given components ***")
        }
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        collectionQuery = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        collectionQuery!.initialResultsHandler = { collectionQuery, HKStatisticsCollection, error in
            completion(HKStatisticsCollection)
        }
        
        if let healthStore = healthStore, let collectionQuery = self.collectionQuery {
            healthStore.execute(collectionQuery)
        }
    }
    
    
    
    func requestAuthorization(completion : @escaping (Bool) -> Void){
        //selectionne stepCount
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        //guard, unwrap
        guard let healthStore = self.healthStore else { return completion(false)}
        
        //authorisation de lire
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
            completion(success)
        }
    }
}

//DONNEES TEST

let MYSTEPSDATA : [DataValue] = [
    DataValue(count: 1845, date: Date()),
    DataValue(count: 54, date: Date() - 1000),
]

let MYSTEPSELEMENT = DataElement (
    identifierInHK: "stepCount",
    customName: "Marche",
    begin: startDateFormatter(year: 2021, month: 06, day: 10),
    impact: 1,
    values: MYSTEPSDATA
)

let MYHRDATA : [DataValue] = [
    DataValue(count: 60, date: Date()),
    DataValue(count: 62, date: Date() - 1000),
]

let MYHRELEMENT = DataElement (
    identifierInHK: "heartRate",
    customName: "Rythme Cardiaque",
    begin: startDateFormatter(year: 2021, month: 06, day: 10),
    impact: 1,
    values: MYHRDATA
)

let MYELEMENTS: [DataElement] = [MYSTEPSELEMENT, MYHRELEMENT]

let MYUSER = UserData(name: "Albert", userElementsList: MYELEMENTS)

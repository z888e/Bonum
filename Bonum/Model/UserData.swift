
//  UserData.swift
//  Bonum
//
//  Created by Zoé Hartman on 16/06/2021.
//

import SwiftUI
import Foundation
import HealthKit

func dateFormatter(year y:Int, month m:Int, day d:Int) -> Date {
    let calendar = Calendar.current
    let dateComponents = DateComponents(calendar: calendar,
                                        year: y,
                                        month: m,
                                        day: d)
    let date = calendar.date(from: dateComponents)!
    return date
}

struct MoodValue : Hashable, Codable {
    
    var timestamp: Date
    var rating: Int // si c'est nil, c'est joker
    var source: Int // 0: tab view, 1: widget, 2: notification
}

struct DataValue: Identifiable, Hashable, Codable, Equatable{
    
    var id = UUID()
    let value: Double
    let date: Date
}

struct DataElement : Identifiable, Codable, Equatable {
    
    var id = UUID()
    var identifierInHK : HKQuantityTypeIdentifier
    var valueNameInHK : String
    var displayedUnit : String
    var displayedSpecifier : String
    var isDiscrete : Bool //false = cumulative, true = discrete
    var customName: String
    var begin: Date
    var end: Date?
    var impact: Int // impact calculé de cette donnée sur la forme
    var values : [DataValue]
}

struct JourneyEvent: Hashable, Codable {
    
    var title: String
    var date: Date
    let imageName: String
    var image: UIImage = UIImage()
    var type: Int // généré automatiquement quand user commence/arrête le suivi d'une donnée, ou jalon personnalisé, ou jalon intelligent
    var moodValue: Int
    
    enum CodingKeys: CodingKey {
        case title, date, imageName, type, moodValue
    }
    
    // nested struct qui permet le stockage d'un nouvel event en cours de création
    struct Data {
        var title: String = ""
        var date: Date = Date()
        var imageName: String = ""
        var type: Int = 0
    }
    
    // propriété calculée qui retourne Data avec les propriétés de JourneyEvent
    var data: Data {
        return Data(title: title, date: date, imageName: imageName, type: type)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        date = data.date
    }

}

//TODO: nom defaut pour les variables suivies

final class UserData: ObservableObject {
    
    var name : String
    
    @Published var userElementsList = [DataElement]()
    @Published var userJourneyEvents = [JourneyEvent]()
    @Published var userMoodHistory = [MoodValue]()
    var healthStore: HKHealthStore?
    var collectionQuery: HKStatisticsCollectionQuery?
    
    // TODO: init à réparer - pb avec le readJson et il ne faut pas retourner de tableau vide
    init(name: String, userElementsList: [DataElement], userJourneyEvents : [JourneyEvent], userMoodHistory : [MoodValue]) {
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()}
        self.name = name
        self.userElementsList = readJson(filename: "ElementsList") ?? userElementsList
        self.userJourneyEvents = readJson(filename: "JourneyList") ?? userJourneyEvents
        self.userMoodHistory = readJson(filename: "MoodsList") ?? userMoodHistory
        
    }
    
    func writeJson<MonType: Codable>(tab : [MonType], filename : String) -> Void {
        let encoder = JSONEncoder()
        do {
            let json = try encoder.encode(tab)
            _ = String(data: json, encoding: .utf8) ?? "error"
            if let url = LocalFileManager.instance.getPathForJson(name: filename){
                try json.write(to: url)
            }
        } catch {
            print(error)
        }
        print("written Json : \(filename)")
    }
    
    func readJson<MonType: Codable>(filename : String) -> MonType?{
        let decoder = JSONDecoder()
        do{
            if let url = LocalFileManager.instance.getPathForJson(name: filename) {
                let data = try Data(contentsOf: url)
                let result = try decoder.decode(MonType.self, from: data)
                print("read Json : \(filename)")
                return result
            }
            return nil
        } catch {
            print(error)
            return nil
        }
    }
    
    func writeNewCumulativeValues(cumulativeTypeDataToRead : HKQuantityTypeIdentifier, startDate : Date, endDate : Date, completion: @escaping (HKStatisticsCollection?) -> Void) {
        let dataType = HKQuantityType.quantityType(forIdentifier: cumulativeTypeDataToRead)!
        
        //anchorDate, moment où le .comp commence
        let calendar = NSCalendar.current
        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
        let offset = (7 + anchorComponents.weekday! - 2) % 7
        anchorComponents.day! -= offset
        anchorComponents.hour = 2
        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
            fatalError("*** Unable to create valid Date from the given components ***")
        }
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        collectionQuery = HKStatisticsCollectionQuery(quantityType: dataType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        collectionQuery!.initialResultsHandler = { collectionQuery, HKStatisticsCollection, error in
            completion(HKStatisticsCollection)
        }
        
        if let healthStore = healthStore, let collectionQuery = self.collectionQuery {
            healthStore.execute(collectionQuery)
        }
    }
    
    func writeNewDiscreteValues(discreteTypeDataToRead : HKQuantityTypeIdentifier, startDate : Date, endDate : Date, completion: @escaping (HKStatisticsCollection?) -> Void) {
        let dataType = HKQuantityType.quantityType(forIdentifier: discreteTypeDataToRead)!
        
        let calendar = NSCalendar.current
        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
        let offset = (7 + anchorComponents.weekday! - 2) % 7
        anchorComponents.day! -= offset
        
        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
            fatalError("*** Unable to create valid Date from the given components ***")
        }
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        collectionQuery = HKStatisticsCollectionQuery(quantityType: dataType, quantitySamplePredicate: predicate, options: .discreteAverage, anchorDate: anchorDate, intervalComponents: daily)
        
        collectionQuery!.initialResultsHandler = { collectionQuery, HKStatisticsCollection, error in
            completion(HKStatisticsCollection)
        }
        
        if let healthStore = healthStore, let collectionQuery = self.collectionQuery {
            healthStore.execute(collectionQuery)
        }
    }
    
}

//DONNEES TEST

let MYSTEPSDATA : [DataValue] = [
    DataValue(value: 1845, date: Date()),
    DataValue(value: 54, date: Date() - 1000)
]

let MYSTEPSELEMENT = DataElement (
    identifierInHK: .stepCount,
    valueNameInHK: HKUnit.count().unitString,
    displayedUnit: "pas",
    displayedSpecifier : "%.f",
    isDiscrete: false,
    customName: "Marche",
    begin: dateFormatter(year: 2021, month: 06, day: 10),
    impact: 1,
    values: MYSTEPSDATA
)

let MYHRDATA : [DataValue] = [
    DataValue(value: 60, date: Date()),
    DataValue(value: 62, date: Date() - 1000),
]

let MYHRELEMENT = DataElement (
    identifierInHK: .heartRate,
    valueNameInHK: HKUnit(from: "count/min").unitString,
    displayedUnit: "BPM",
    displayedSpecifier : "%.f",
    isDiscrete: true,
    customName: "Rythme Cardiaque",
    begin: dateFormatter(year: 2021, month: 06, day: 10),
    impact: 1,
    values: MYHRDATA
)

let MYELEMENTS: [DataElement] = [MYSTEPSELEMENT, MYHRELEMENT]

let MYJOURNEY : [JourneyEvent] = [
    JourneyEvent(title: "Premier job", date: Date()-(86400*365), imageName: "vie-active", type: 0, moodValue: 7),
    JourneyEvent(title: "Inscription à la salle", date: Date()-(86400*330), imageName: "inscription-salle", type: 0, moodValue: 9),
    JourneyEvent(title: "Accident de la route", date: Date()-(86400*340), imageName: "accident", type: 0, moodValue: 8),
    JourneyEvent(title: "Vacances à Lanzarote", date: Date()-(86400*300), imageName: "lanzarote", type: 0, moodValue: 6),
    JourneyEvent(title: "Vie à deux", date: Date()-(86400*250), imageName: "vie-a-deux", type: 0, moodValue: 7),
    JourneyEvent(title: "Déménagement", date: Date()-(86400*100), imageName: "demenagement", type: 0, moodValue: 3),
    JourneyEvent(title: "Arrêt de la cigarette", date: Date()-(86400*80), imageName: "arret-cigarette", type: 0, moodValue: 8),
    JourneyEvent(title: "Naissance d'Emilie", date: Date()-(86400*15), imageName: "naissance-emilie", type: 0, moodValue: 7)
]

let MYMOODS : [MoodValue] = [
    MoodValue(timestamp: Date()-(86400*7), rating: 7, source: 0),
    MoodValue(timestamp: Date()-(86400*6), rating: 9, source: 0),
    MoodValue(timestamp: Date()-(86400*5), rating: 8, source: 0),
    MoodValue(timestamp: Date()-(86400*4), rating: 6, source: 0),
    MoodValue(timestamp: Date()-(86400*3), rating: 7, source: 0),
    MoodValue(timestamp: Date()-(86400*2), rating: 3, source: 0),
    MoodValue(timestamp: Date()-(86400), rating: 8, source: 0)
]


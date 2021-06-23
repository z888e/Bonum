
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

func dateToString(date: Date, format: String) -> String {
    let formatter = DateFormatter()
    
    var formatOut: String {
        switch format {
        case "Date" : return "d MMM y"
        case "Time": return "HH:mm:ss"
        case "DateTimeShort": return "d MMM y, HH:mm"
        case "DateTimeLong": return "d MMM y, HH:mm:ss"
        default: return "d MMM y, HH:mm:ss"
        }
    }
    formatter.locale = Locale(identifier: "fr")
    formatter.dateFormat = formatOut
    return formatter.string(from: date)
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

struct JourneyEvent: Identifiable, Hashable, Codable {
    
    var id = UUID()
    var title: String
    var date: Date
    var imageName: String
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
//        imageName = imageName.isEmpty ? UUID().uuidString : imageName
        
//        print("Save image with name: \(imageName)")
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
    JourneyEvent(title: "Inscription à la salle", date: Date()-(86400*340), imageName: "inscription-salle", type: 0, moodValue: 9),
    JourneyEvent(title: "Accident de la route", date: Date()-(86400*330), imageName: "accident", type: 0, moodValue: 8),
    JourneyEvent(title: "Vacances à Lanzarote", date: Date()-(86400*300), imageName: "lanzarote", type: 0, moodValue: 6),
    JourneyEvent(title: "Vie à deux", date: Date()-(86400*250), imageName: "vie-a-deux", type: 0, moodValue: 7),
    JourneyEvent(title: "Déménagement", date: Date()-(86400*100), imageName: "demenagement", type: 0, moodValue: 3),
    JourneyEvent(title: "Arrêt de la cigarette", date: Date()-(86400*80), imageName: "arret-cigarette", type: 0, moodValue: 8),
    JourneyEvent(title: "Naissance d'Emilie", date: Date()-(86400*15), imageName: "naissance-emilie", type: 0, moodValue: 7)
]

let EMPTYJOURNEYEVENT = JourneyEvent(title: "", date: Date(), imageName: "", type: 0, moodValue: 5)

let MYMOODS : [MoodValue] = [
    MoodValue(timestamp: Date()-(86400*7), rating: 7, source: 0),
    MoodValue(timestamp: Date()-(86400*6), rating: 9, source: 0),
    MoodValue(timestamp: Date()-(86400*5), rating: 8, source: 0),
    MoodValue(timestamp: Date()-(86400*4), rating: 6, source: 0),
    MoodValue(timestamp: Date()-(86400*3), rating: 7, source: 0),
    MoodValue(timestamp: Date()-(86400*2), rating: 3, source: 0),
    MoodValue(timestamp: Date()-(86400), rating: 8, source: 0)
]

let MYMOODS2: [MoodValue] = [
    MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631152000), rating: 3, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631238400), rating: 3, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631324800), rating: 3, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631411200), rating: 3, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631497600), rating: 4, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631584000), rating: 4, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631670400), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631756800), rating: 4, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631843200), rating: 3, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 631929600), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632016000), rating: 4, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632102400), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632188800), rating: 3, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632275200), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632361600), rating: 3, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632448000), rating: 3, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632534400), rating: 4, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632620800), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632707200), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632793600), rating: 3, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632880000), rating: 3, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 632966400), rating: 2, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633052800), rating: 3, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633139200), rating: 3, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633225600), rating: 2, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633312000), rating: 3, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633398400), rating: 2, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633484800), rating: 3, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633571200), rating: 2, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633657600), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633744000), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633830400), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 633916800), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634003200), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634089600), rating: 2, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634176000), rating: 2, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634262400), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634348800), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634435200), rating: 2, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634521600), rating: 2, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634608000), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634694400), rating: 2, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634780800), rating: 2, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634867200), rating: 3, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 634953600), rating: 2, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635040000), rating: 3, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635126400), rating: 3, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635212800), rating: 3, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635299200), rating: 3, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635385600), rating: 2, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635472000), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635558400), rating: 3, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635644800), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635731200), rating: 4, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635817600), rating: 3, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635904000), rating: 3, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 635990400), rating: 5, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636076800), rating: 5, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636163200), rating: 5, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636249600), rating: 4, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636336000), rating: 5, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636422400), rating: 6, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636508800), rating: 5, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636595200), rating: 6, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636681600), rating: 5, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636768000), rating: 5, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636854400), rating: 5, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 636940800), rating: 6, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637027200), rating: 8, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637113600), rating: 9, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637200000), rating: 7, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637286400), rating: 7, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637372800), rating: 7, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637459200), rating: 9, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637545600), rating: 6, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637632000), rating: 9, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637718400), rating: 9, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637804800), rating: 10, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637891200), rating: 8, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 637977600), rating: 8, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638064000), rating: 8, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638150400), rating: 7, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638236800), rating: 7, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638323200), rating: 10, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638409600), rating: 10, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638496000), rating: 8, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638582400), rating: 9, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638668800), rating: 8, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638755200), rating: 10, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638841600), rating: 8, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 638928000), rating: 8, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639014400), rating: 7, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639100800), rating: 10, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639187200), rating: 7, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639273600), rating: 9, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639360000), rating: 9, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639446400), rating: 6, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639532800), rating: 10, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639619200), rating: 8, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639705600), rating: 6, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639792000), rating: 8, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639878400), rating: 6, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 639964800), rating: 7, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640051200), rating: 7, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640137600), rating: 6, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640224000), rating: 6, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640310400), rating: 6, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640396800), rating: 5, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640483200), rating: 4, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640569600), rating: 4, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640656000), rating: 4, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640742400), rating: 3, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640828800), rating: 3, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 640915200), rating: 2, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641001600), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641088000), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641174400), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641260800), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641347200), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641433600), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641520000), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641606400), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641692800), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641779200), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641865600), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 641952000), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642038400), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642124800), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642211200), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642297600), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642384000), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642470400), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642556800), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642643200), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642729600), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642816000), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642902400), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 642988800), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643075200), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643161600), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643248000), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643334400), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643420800), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643507200), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643593600), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643680000), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643766400), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643852800), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 643939200), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644025600), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644112000), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644198400), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644284800), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644371200), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644457600), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644544000), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644630400), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644716800), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644803200), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644889600), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 644976000), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645062400), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645148800), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645235200), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645321600), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645408000), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645494400), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645580800), rating: 1, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645667200), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645753600), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645840000), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 645926400), rating: 1, source: 2), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 646012800), rating: 1, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 646099200), rating: 2, source: 1), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 646185600), rating: 6, source: 0), MoodValue(timestamp: Date(timeIntervalSinceReferenceDate: 646272000), rating: 7, source: 2)]

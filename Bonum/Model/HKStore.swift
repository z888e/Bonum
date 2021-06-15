
//
//  HKStore.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import Foundation
import HealthKit

let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())
let endDate = Date()

class HealthStoreData : ObservableObject {
    
    var healthStore: HKHealthStore?
    var collectionQuery: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()
        }
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

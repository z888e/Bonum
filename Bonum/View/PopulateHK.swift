//
//  PopulateHK.swift
//  Bonum
//
//  Created by Zoé Hartman on 22/06/2021.
//

import SwiftUI
import HealthKit

struct PopulateHK : View {
    
    @EnvironmentObject var userData: UserData
    
    var STEPSADDED = DATAVALUES
    
    func addStepsToHealthKit() {
        
        userData.healthStore!.requestAuthorization(toShare: Set([HKObjectType.quantityType(forIdentifier: .stepCount)!]), read: []) { (result, error) in
            if let error = error {
                print(error)
                return
            }
            guard result else {
                return
            }
        }
        
        for step in STEPSADDED.enumerated() {
            let value : Double = step.element.value
            let date : Date = step.element.date
            let quantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)
            let quantitytUnit : HKUnit = HKUnit.count()
            let dataValue = HKQuantity(unit: quantitytUnit, doubleValue: value)
            
            let sample = HKQuantitySample(type: quantityType!, quantity: dataValue, start: date, end: date)
            let correlationType = HKObjectType.correlationType(forIdentifier: HKCorrelationTypeIdentifier.food)
            
            let corr = HKCorrelation(type: correlationType!, start: date, end: date, objects: [sample])
    
            userData.healthStore?.save(corr, withCompletion: { (success, error) in
                if (error != nil) {
                    print(error!)
                }
            })
            
        }
    }
    
    var body : some View {
        VStack{
            Button(action: {
                addStepsToHealthKit()
            }, label: {
                Text("Add to HK")
                    .padding(20)
            })
        
        }
    }
}


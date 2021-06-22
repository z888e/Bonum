////
////  HKNewDataAuthAndRetreival.swift
////  Bonum
////
////  Created by Zoé Hartman on 18/06/2021.
////
//
//import SwiftUI
//import HealthKit
//
//struct HKNewDataAuthAndRetreival : View {
//    
//    @EnvironmentObject var userData:UserData
//    
//    let customName : String
//    var dataType : HKObjectType = HKObjectType.quantityType(forIdentifier: .heartRate)!
//
//    
//    var body: some View {
//        func setDataType(name : String = customName) -> HKObjectType{
//            if name == "Nombre de pas" {
//                dataType = HKObjectType.quantityType(forIdentifier: .stepCount)!
//            }
//            if name == "Rythme Cardiaque" {
//                dataType = HKObjectType.quantityType(forIdentifier: .heartRate)!
//            }
//            if name == "Variabilité Cardiaque" {
//                dataType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
//            }
//            return dataType
//        }
//        
//        Text("Utiliser \(customName) nécessite votre autorisation.")
//        
//        Button(action: {
//            if HKHealthStore.isHealthDataAvailable() {
//                let healthStore = HKHealthStore()
//                
//                let unwrappedDataType = Set([dataType])
//                
//                healthStore.requestAuthorization(toShare: nil, read: unwrappedDataType) { (result, error) in
//                    if let error = error {
//                        print(error)
//                        return
//                    }
//                    guard result else {
//                        print("Failed request")
//                        return
//                    }
//                    
//                }
//            }
//        }, label: {
//            HStack{
//                Spacer()
//                Text("Autoriser").padding(30)
//                Spacer()
//            }
//        }
//        )
//    }
//}

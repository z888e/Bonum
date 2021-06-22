//
//  AddElement.swift
//  Bonum
//
//  Created by Zoé Hartman on 18/06/2021.
//

import SwiftUI
import HealthKit

extension HKQuantityTypeIdentifier : Codable {}

struct AddElement: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    @State private var identifierInHK : HKQuantityTypeIdentifier = .heartRate
    @State private var valueNameInHK : HKUnit = HKUnit(from: "count/min")
    @State private var customName = "Choisir"
    @State private var isDiscrete = false
    @State private var begin = Date()
    @State private var values = [DataValue]()
    @State private var authorized = false
    @State private var dataRetreived : Bool = false
    @State private var showingAlert = false
    @State private var unwrappedDataType : Set<HKObjectType> = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
    @State private var idType : HKQuantityTypeIdentifier = .heartRate
    
    //TODO remplir ce tab
    //    let allHTDataTypes: [String] = []
    // get tous les elements que l'user suit TODO juste le nom
    //    let alreadyTrackedElements = userData.userElementsList
    //TODO comparer
    var unusedAvailableHKTypes = ["Choisir", "Nombre de pas", "Rythme Cardiaque", "Variabilité Cardiaque", "Activité en exercice", "Temperature corporelle"]
    
    private func populateCumulativeElementValues(_ statisticsCollection: HKStatisticsCollection, valueNameInHK : HKUnit) {
        
        statisticsCollection.enumerateStatistics(from: begin, to: Date()) {
            (statistics, stop) in
            
            var value : Double{statistics.sumQuantity()?.doubleValue(for: valueNameInHK) ?? 1.0}
            
            let newDataValue = DataValue(value: value, date: statistics.startDate)
            values.append(newDataValue)
        }
    }
        
    private func populateDiscreteElementValues(_ statisticsCollection: HKStatisticsCollection, valueNameInHK : HKUnit) {
        statisticsCollection.enumerateStatistics(from: begin, to: Date()) {
            (statistics, stop) in
            
            let value = statistics.averageQuantity()?.doubleValue(for: valueNameInHK)
            
            let newDataValue = DataValue(value: value ?? 1.0, date: statistics.startDate)
            values.append(newDataValue)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                if !authorized {
                    Text("Ajouter une donnée à suivre").font(.title).padding()
                    
                    Picker(selection: $customName, label: Text("Color")) {
                        ForEach(unusedAvailableHKTypes, id: \.self) { el in
                            Text(el)
                        }
                    }
                } else if !dataRetreived {
                    Text("Ajouter " + customName).font(.title2)
                }
                
                if customName != "Choisir" && !authorized {
                    Text("Utiliser \(customName) nécessite votre autorisation.")
                    
                    Button(action: {
                        showingAlert = true
                    }) {
                        HStack{
                            Text("Besoin d'aide ")
                            Image(systemName: "questionmark.circle")
                        }.padding()
                    }
                    .alert(isPresented: self.$showingAlert) {
                        Alert(title: Text("Aide"), message:   Text("""
Bonum utilise les données correspondant à l'élément choisi dans Santé.
Si vous suivez cette donnée pour la première fois, une demande d'autorisation apparaitra.
Si vous avec déjà autorisé cet élément dans Santé, vous pourrez passer à la prochaine étape.
Si vous avez déjà refusé l'accès à cette donnée, veuillez aller dans "Réglages > Santé > Accès aux données et appareils > Bonum" et modifier sa permission afin de pouvoir l'utiliser.
"""), dismissButton: .default(Text("Ok")))
                    }
                    
                    Button(action: {
                        func setIdType(name : String = customName) -> HKQuantityTypeIdentifier {
                            if name == "Nombre de pas" {
                                idType = .stepCount
                                valueNameInHK = HKUnit.count()
                            }
                            if name == "Rythme Cardiaque" {
                                idType = .heartRate
                                valueNameInHK = HKUnit(from: "count/min")
                                isDiscrete = true
                            }
                            if name == "Variabilité Cardiaque" {
                                idType = .heartRateVariabilitySDNN
                                valueNameInHK = HKUnit.secondUnit(with: .milli)
                                isDiscrete = true
                            }
                            if name == "Activité en exercice" {
                                idType = .activeEnergyBurned
                                valueNameInHK = HKUnit.kilocalorie()
                            }
                            if name == "Temperature corporelle" {
                                idType = .bodyTemperature
                                valueNameInHK = HKUnit.degreeCelsius()
                                isDiscrete = true
                            }
                            return idType
                        }
                        
                        idType = setIdType()
                        identifierInHK = idType
                        print(identifierInHK)
                        let dataType : HKObjectType = HKObjectType.quantityType(forIdentifier: idType)!
                        print(dataType)
                        let unwrappedDataType = Set([dataType])
                        print(unwrappedDataType)
                        print(isDiscrete ? "type is Discrete" : "type is Cumulative")
                        print(values)
                        
                        userData.healthStore!.requestAuthorization(toShare: nil, read: unwrappedDataType) { (result, error) in
                            if let error = error {
                                print(error)
                                return
                            }
                            guard result else {
                                return
                            }
                            authorized = true
                        }
                        
                    }
                    , label: {
                        HStack{
                            Spacer()
                            Text("Autoriser").padding(30)
                            Spacer()
                        }
                    }
                    )
                }
                
                if authorized && !dataRetreived {
                    VStack(alignment: .leading){
                        Text("A partir de quelle date analyser cet élément?")
                        DatePicker("A partir de", selection: $begin, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    } .padding(30)
                    
                    Button(action: {
                        if let healthStore = userData.healthStore {
                            healthStore.requestAuthorization(toShare: [], read: unwrappedDataType) { success,error  in
                                if success {
                                    if isDiscrete {
                                        userData.writeNewDiscreteValues(discreteTypeDataToRead: idType, startDate: begin, endDate: Date()){ statisticsCollection in
                                            if let statisticsCollection = statisticsCollection {
                                                populateDiscreteElementValues(statisticsCollection, valueNameInHK: valueNameInHK)
                                            }
                                        }
                                    }
                                    if !isDiscrete {
                                        userData.writeNewCumulativeValues(cumulativeTypeDataToRead: idType, startDate: begin, endDate: Date()){ statisticsCollection in
                                            if let statisticsCollection = statisticsCollection {
                                                populateCumulativeElementValues(statisticsCollection, valueNameInHK: valueNameInHK)
                                            }
                                        }
                                    }
                                    dataRetreived = true
                                }
                            }
                        }
                        
                    }, label: {
                        Text("Valider").padding(20)
                    })
                }
                
                if dataRetreived {
                    
                    Button(action: {
                        let newElement = DataElement(
                            identifierInHK: identifierInHK,
                            valueNameInHK: valueNameInHK.unitString,
                            isDiscrete: isDiscrete,
                            customName: customName,
                            begin: begin,
                            impact:0,
                            values: values
                        )
                        
                        print(values)
                        
                        userData.userElementsList.append(newElement)
                        userData.writeJson(tab: userData.userElementsList, filename: "ElementsList")
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Ajouter \(customName) comme élément Bonum")
                    })
                    
                }
            }.navigationBarHidden(true)
        }
    }
}

struct AddElement_Previews: PreviewProvider {
    static var previews: some View {
        AddElement()
    }
}

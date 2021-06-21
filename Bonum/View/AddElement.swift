//
//  AddElement.swift
//  Bonum
//
//  Created by Zoé Hartman on 18/06/2021.
//

import SwiftUI
import HealthKit

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

extension HKQuantityTypeIdentifier : Codable {
    
}

struct AddElement: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    @State private var newElement : DataElement = DataElement(identifierInHK: .heartRate, customName: " ", begin: Date(), impact: 0, values: [DataValue]())
    @State private var identifierInHK : HKQuantityTypeIdentifier = .heartRate
    @State private var customName = "Choisir"
    @State private var begin = Date()
    @State private var values = [DataValue]()
    @State private var authorized : Bool = false
    @State private var showingAlert = false
    @State private var unwrappedDataType : Set<HKObjectType> = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
    
    var healthStore: HKHealthStore?
    
    //TODO remplir ce tab
//    let allHTDataTypes: [String] = []
    // get tous les elements que l'user suit TODO juste le nom
//    let alreadyTrackedElements = userData.userElementsList
    //TODO comparer
    var unusedAvailableHKTypes = ["Choisir", "Nombre de pas", "Rythme Cardiaque", "Variabilité Cardiaque", "Activité en exercice"]
        
    private func populateElementValues(_ statisticsCollection: HKStatisticsCollection){
        
        statisticsCollection.enumerateStatistics(from: begin, to: Date()) {
            (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = DataValue(count: count ?? 0, date: statistics.startDate)
            newElement.values = [step]
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
                } else  {
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
                        if HKHealthStore.isHealthDataAvailable() {
                            let healthStore = HKHealthStore()
                            var dataType : HKObjectType = HKObjectType.quantityType(forIdentifier: .heartRate)!
                            
                            func setDataType(name : String = customName) -> HKObjectType{
                                if name == "Nombre de pas" {
                                    dataType = HKObjectType.quantityType(forIdentifier: .stepCount)!
                                }
                                if name == "Rythme Cardiaque" {
                                    dataType = HKObjectType.quantityType(forIdentifier: .heartRate)!
                                }
                                if name == "Variabilité Cardiaque" {
                                    dataType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
                                }
                                if name == "Activité en exercice" {
                                    dataType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
                                }
                                return dataType
                            }
                            
                            dataType = setDataType()
                            let unwrappedDataType = Set([dataType])
                            
                            healthStore.requestAuthorization(toShare: nil, read: unwrappedDataType) { (result, error) in
                                if let error = error {
                                    print(error)
                                    return
                                }
                                guard result else {
                                    print("Failed request")
                                    return
                                }
                                authorized = true
                            }
                            
                        }
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Autoriser").padding(30)
                            Spacer()
                        }
                    }
                    )
                }
                
                if authorized {
                    VStack(alignment: .leading){
                        Text("A partir de quelle date analyser cet élément?")
                        DatePicker("A partir de", selection: $begin, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    } .padding(30)
                    
                    Button(action: {
                        newElement = DataElement(
                            identifierInHK: identifierInHK,
                            customName: customName,
                            begin: begin,
                            impact:0,
                            values: values
                        )
                        if let healthStore = healthStore {
                            healthStore.requestAuthorization(toShare: [], read: unwrappedDataType) { success,error  in
                                if success {
                                    userData.calculateSteps{ statisticsCollection in
                                        if let statisticsCollection = statisticsCollection {
                                            print(statisticsCollection)
                                            populateElementValues(statisticsCollection)
                                        }
                                    }
                                }
                            }
                        }
                        
                        userData.userElementsList.append(newElement)
                        userData.writeJson(tab: userData.userElementsList, filename: "ElementsList")
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Valider").padding(20)
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

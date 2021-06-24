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
    @State private var displayedUnit : String = "BPM"
    @State private var displayedSpecifier : String = "%.f"
    @State private var customName = "Choisir"
    @State private var isDiscrete = false
    @State private var impact = 0
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
            
            var value : Double{statistics.sumQuantity()?.doubleValue(for: valueNameInHK) ?? 0.0}
            
            let newDataValue = DataValue(value: value, date: statistics.startDate)
            values.append(newDataValue)
        }
    }
    
    private func populateDiscreteElementValues(_ statisticsCollection: HKStatisticsCollection, valueNameInHK : HKUnit) {
        statisticsCollection.enumerateStatistics(from: begin, to: Date()) {
            (statistics, stop) in
            
            let value = statistics.averageQuantity()?.doubleValue(for: valueNameInHK)
            
            let newDataValue = DataValue(value: value ?? 0.0, date: statistics.startDate)
            values.append(newDataValue)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                if !authorized {
                    Text("Ajouter un élément")
                        .font(.title)
                        .padding(.bottom, 30)
                        .foregroundColor(Color("AppColor3"))
                    
                    Picker(selection: $customName, label: Text("Color")) {
                        ForEach(unusedAvailableHKTypes, id: \.self) { el in
                            Text(el)
                        }.foregroundColor(Color("AppColor3"))
                    }
                }
                
                if customName != "Choisir" && !authorized {
                    HStack{
                        VStack(alignment : .leading, spacing:10){
                            Text("Utiliser \(customName) nécessite votre autorisation.").padding(.horizontal, 20).foregroundColor(Color("AppColorWhite"))
                            
                            Button(action: {
                                showingAlert = true
                            }) {
                                HStack{
                                    Text("Besoin d'aide ").foregroundColor(Color("AppColor1"))
                                    Image(systemName: "questionmark.circle").foregroundColor(Color("AppColor1"))
                                    Spacer()
                                }.padding(.horizontal, 20)
                            }
                            .alert(isPresented: self.$showingAlert) {
                                Alert(title: Text("Aide"), message:   Text("""
        Bonum utilise les données correspondant à l'élément choisi dans Santé.
        Si vous suivez cette donnée pour la première fois, une demande d'autorisation apparaitra.
        Si vous avec déjà autorisé cet élément dans Santé, vous pourrez passer à la prochaine étape.
        Si vous avez déjà refusé l'accès à cette donnée, veuillez aller dans "Réglages > Santé > Accès aux données et appareils > Bonum" et modifier sa permission afin de pouvoir l'utiliser.
        """), dismissButton: .default(Text("Ok")))
                            }
                        }.padding(.vertical, 20)
                        Spacer()
                    }.background(Color("AppColor3"))
                    
                    
                    Button(action: {
                        func setIdType(name : String = customName) -> HKQuantityTypeIdentifier {
                            if name == "Nombre de pas" {
                                idType = .stepCount
                                valueNameInHK = HKUnit.count()
                                displayedUnit = "pas"
                                displayedSpecifier = "%.f"
                                impact = 2
                            }
                            if name == "Rythme Cardiaque" {
                                idType = .heartRate
                                valueNameInHK = HKUnit(from: "count/min")
                                displayedUnit = "BPM"
                                displayedSpecifier = "%.f"
                                isDiscrete = true
                            }
                            if name == "Variabilité Cardiaque" {
                                idType = .heartRateVariabilitySDNN
                                valueNameInHK = HKUnit.secondUnit(with: .milli)
                                displayedUnit = "ms"
                                displayedSpecifier = "%.f"
                                isDiscrete = true
                            }
                            if name == "Activité en exercice" {
                                idType = .activeEnergyBurned
                                valueNameInHK = HKUnit.kilocalorie()
                                displayedUnit = "kCal"
                                displayedSpecifier = "%.f"
                            }
                            if name == "Temperature corporelle" {
                                idType = .bodyTemperature
                                valueNameInHK = HKUnit.degreeCelsius()
                                displayedUnit = "°C"
                                displayedSpecifier = "%.1f"
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
                            Text("Autoriser")
                                .foregroundColor(Color("AppColorWhite"))
                                .fontWeight(.semibold)
                                .padding()
                                .frame(width: 250, height: 50)
                                .background(Color("AppColor1"))
                                .cornerRadius(20)
                                .shadow(radius: 1)
                            Spacer()
                        }.padding(40)
                    }
                    )
                }
                
                if authorized && !dataRetreived {
                    VStack{
                        Text("A partir de quelle date analyser cet élément?")
                            .foregroundColor(Color("AppColor3"))
                            .font(.title2)
                            .padding(.bottom, 50)
                        DatePicker("", selection: $begin, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .saturation(0.0)
                            .colorMultiply(Color("AppColor1"))
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
                        HStack{
                            Spacer()
                            Text("Valider")
                                .foregroundColor(Color("AppColorWhite"))
                                .fontWeight(.semibold)
                                .padding()
                                .frame(width: 250, height: 50)
                                .background(Color("AppColor1"))
                                .cornerRadius(20)
                                .shadow(radius: 1)
                            Spacer()
                        }.padding(.bottom, 40)
                    })
                }
                
                if dataRetreived {
                    VStack{
                        HStack{
                            Text(customName).font(.title)
                            Image(systemName: "checkmark").foregroundColor(Color("AppColor1")).font(.title)
                            Spacer()
                        }.padding(.horizontal, 20)
                        HStack{
                            Text("Depuis le " + dateToString(date: begin, format: "DateShort")).font(.title)
                            Image(systemName: "checkmark").foregroundColor(Color("AppColor1")).font(.title)
                            Spacer()
                        }.padding(.horizontal, 20)

                    }
                    Button(action: {
                        let newElement = DataElement(
                            identifierInHK: identifierInHK,
                            valueNameInHK: valueNameInHK.unitString,
                            displayedUnit: displayedUnit,
                            displayedSpecifier : displayedSpecifier,
                            isDiscrete: isDiscrete,
                            customName: customName,
                            begin: begin,
                            impact:impact,
                            values: values
                        )
                        
                        print(values)
                        
                        userData.userElementsList.append(newElement)
                        userData.writeJson(tab: userData.userElementsList, filename: "ElementsList")
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Ajouter le nouvel élément")
                                .foregroundColor(Color("AppColorWhite"))
                                .fontWeight(.semibold)
                                .padding()
                                .frame(width: 270, height: 50)
                                .background(Color("AppColor1"))
                                .cornerRadius(20)
                                .shadow(radius: 1)
                            Spacer()
                        }.padding(.vertical, 60)
                    })
                    
                }
            }.navigationBarHidden(true)
        }.background(Color("AppColorWhite"))
    }
}

struct AddElement_Previews: PreviewProvider {
    static var previews: some View {
        AddElement()
    }
}

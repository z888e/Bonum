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

struct AddElement: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAddForm = false
    @State private var newElement : DataElement = DataElement(identifierInHK: " ", customName: " ", begin: Date(), impact: 0, values: [DataValue]())
    @State private var identifierInHK = " "
    @State private var customName = "Choisir"
    @State private var begin = Date()
    @State private var values = [DataValue]()
    
    @State private var authorized : Bool = false
    @State private var alreadyUnauthorized : Bool = false
    
    //?
    //remplir ce tab
    let allHTDataTypes: [String] = []
    // get tous les elements que l'user suit
    //    userData.userElementsList.
    //comparer
    var unusedAvailableHKTypes = ["Choisir", "Nombre de pas", "Rythme Cardiaque", "Variabilité Cardiaque", "Masse grasse"]
    
    
    //TODO: JSON reload
    
    var body: some View {
        NavigationView{
            VStack{
                if !authorized && !alreadyUnauthorized{
                    Text("Ajouter une donnée à suivre").font(.title).padding()
                    
                    Picker(selection: $customName, label: Text("Color")) {
                        ForEach(unusedAvailableHKTypes, id: \.self) { el in
                            Text(el)
                        }
                    }
                } else if !alreadyUnauthorized {
                    Text("Ajouter " + customName).font(.title2)
                }
                
                if customName != "Choisir" && !authorized && !alreadyUnauthorized {
                    Text("Utiliser \(customName) nécessite votre autorisation.")
                    
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
                                if name == "Masse grasse" {
                                    dataType = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)!
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
                            
//                           let authorizationStatus = healthStore.authorizationStatus(for: dataType)
//                            print(authorizationStatus.rawValue)
//
//                            switch authorizationStatus.rawValue {
//                            case 2: authorized = true
//                            case 1: alreadyUnauthorized = true
//                            case 0: print("launch of HK auth by Apple")
//                            default:
//                                print("unknown status")
//                            }
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
                
//                if !authorized && alreadyUnauthorized {
//                    if alreadyUnauthorized {
//                        Text("Vous avez refusé l'autorisation pour l'element \(customName). Veuillez aller dans Réglages > Santé > Accès aux données et appareils > Bonum afin de pouvoir l'utiliser.").padding()
//                    }
//                }
                
                if !alreadyUnauthorized && authorized {
                    VStack(alignment: .leading){
                        Text("A partir de quelle date analyser cet élément?")
                        DatePicker("A partir de", selection: $begin, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    } .padding(30)
                    
                    Button(action: {
                        newElement = DataElement(
                            identifierInHK: identifierInHK,
                            customName: customName,
                            begin: Date(),
                            impact:0,
                            values: values
                        )
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

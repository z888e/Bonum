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
    
    //?
    //remplir ce tab
    let allHTDataTypes: [String] = []
    // get tous les elements que l'user suit
    //    userData.userElementsList.
    //comparer
    var ourAvailableHKTypes = ["Choisir", "Nombre de pas", "Rythme Cardiaque", "Variabilité Cardiaque"]
    
    //    var dataType : HKObjectType = HKObjectType.quantityType(forIdentifier: .heartRate)!
    
    
    //TODO: JSON reload
    
    var body: some View {
        NavigationView{
            VStack{
                if !authorized {
                    Text("Ajouter une donnée à suivre").font(.title).padding()

                    Picker("Element à suivre", selection: $customName) {
                        ForEach(ourAvailableHKTypes, id: \.self) {
                            Text($0)
                        }
                    }
                } else {
                    Text("Ajouter " + customName).font(.title2)
                }
                
                //TODO: l'action du boutton jusqu'à la requete d'autorisation doit se faire au changement du picker
                
                if customName != "Choisir" && !authorized {
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
                                return dataType
                            }
                            
                            dataType = setDataType()
                            let unwrappedDataType = Set([dataType])
                            
                           let authorizationStatus = healthStore.authorizationStatus(for: dataType)

                            switch authorizationStatus {
                            case .sharingAuthorized: authorized = true
                            case .sharingDenied: print("Changer dans Santé")
                            default: print("not determined")
                            }
                                
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

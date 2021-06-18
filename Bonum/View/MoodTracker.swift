//
//  MoodTracker.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//
// !!!! Ajouter JOKER + Source de l'affichage du mood tracker + new look

import SwiftUI

struct MoodTracker: View {
    
    @EnvironmentObject var userData: UserData
    @State private var scoreEntered : Double = 5
    
    @State private var newMoodValue: MoodValue = MoodValue(timestamp: Date(), rating: 0, source: 0)
    
    // Pour afficher l'historique par date de saisie la plus récente
    var sortedMoodHistory: [MoodValue] {
        return userData.userMoodHistory.sorted {
            $0.timestamp > $1.timestamp
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack{
                
                HStack{
                    HStack{
                        Text("1")
                        Spacer()
                        Text("2")
                        Spacer()
                        Text("3")
                        Spacer()
                        Text("4")
                        Spacer()
                        Text("5")
                        Spacer()
                    }
                    HStack{
                        Text("6")
                        Spacer()
                        Text("7")
                        Spacer()
                        Text("8")
                        Spacer()
                        Text("9")
                        Spacer()
                        Text("10")
                    }
                }
                .padding(.horizontal, 20.0)
                
                Slider(value: $scoreEntered, in: 1...10, step: 1).padding()
                //TODO : valeurs/sensibilite du slider, ou stepper avec style custom?
                
                Button(action: {
                    //TODO:append le mood avec la date et le type
                    newMoodValue = MoodValue(timestamp: Date(), rating: Int(scoreEntered), source: 0)
                    userData.userMoodHistory.append(newMoodValue)
                    userData.writeJson(tab: userData.userMoodHistory, filename: "MoodsList")
                }, label: {
                    //TODO: texte
                    Text("Valider")
                })
                
            }
            
            
            //uniquement pour verifier que le JSON est chargé
            Text("Historique des Notes").padding()
            
            List {
                ForEach(sortedMoodHistory, id: \.self) { moodEntry in
                    
//                    let entry = String(moodEntry.rating ?? 0)
//                    Text(entry)
                    MoodCell(mood: moodEntry)
                    
                }
            }.padding()
            .listStyle(PlainListStyle())
            
            
        }
        //        .navigationTitle("Parcours")
        //        .navigationBarItems(trailing:
        //                                NavigationLink("Nouveau jalon", destination: Text("Ajout d'un nouveau jalon"))
        //        )
        
    }
}

struct MoodTracker_Previews: PreviewProvider {
    
    static var previews: some View {
        MoodTracker()
            .environmentObject(UserData(name: "Albert", userElementsList: MYELEMENTS, userJourneyEvents: MYJOURNEY, userMoodHistory: MYMOODS))
    }
}




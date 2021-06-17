//
//  MoodTracker.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct MoodTracker: View {
    
    @EnvironmentObject var userData:UserData
    @State private var scoreEntered : Double = 5
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Slider(value: $scoreEntered, in: 0...10).padding()
            //TODO : valeurs/sensibilite du slider, ou stepper avec style custom?
            
            Button(action: {
                //TODO:append le mood avec la date et le type
            }, label: {
                //TODO: texte
                Text("Valider")
            })
            
            //uniquement pour verifier que le JSON est chargé
            Text("Historique des Notes").padding()

            List {
                ForEach(userData.userMoodHistory, id: \.self) { moodEntry in
                    
                    let entry = String(moodEntry.rating ?? 0)
                    Text(entry)
                    
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
    }
}




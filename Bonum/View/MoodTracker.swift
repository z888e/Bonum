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
    // Permet de stocker le dernier score et sa date
    @State private var newMoodValue: MoodValue = MoodValue(timestamp: Date(), rating: 0, source: 0)
    @AppStorage("lastMoodDate") private var lastMoodDate: Date = Date()
    let noticationManager = NotificationDelegate()
    
    let dateW = UserDefaults.group.object(forKey: "dateW") as? String ?? "No date"

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
                
                Text(dateW)

                
                Slider(value: $scoreEntered, in: 1...10, step: 1).padding()
                //TODO : valeurs/sensibilite du slider, ou stepper avec style custom?
                
                Button(action: {
                    // Ajoute le mood au Json, avec la date et le type + stocke dans les userdefault la date de dernière notation + màj les relances
                    newMoodValue = MoodValue(timestamp: Date(), rating: Int(scoreEntered), source: 0)
                    userData.userMoodHistory.append(newMoodValue)
                    userData.writeJson(tab: userData.userMoodHistory, filename: "MoodsList")
                    lastMoodDate = Date()
                    noticationManager.smartNotification(lastEnreg: Date(), interval: 75)
                    UserDefaults.group.set(dateToString(date: Date()), forKey: "dateW")
                    

                }, label: {
                    //TODO: texte
                    Text("Valider")
                })
                
            }
            
            //uniquement pour tester le stockage de dernière notation
            //            Text(lastMoodDate, style: .date)
            //            Text(lastMoodDate, style: .time)
            
            //uniquement pour verifier que le JSON est chargé
            Text("Historique des Etats de Forme").padding()
            
            List {
                ForEach(sortedMoodHistory, id: \.self) { moodEntry in
                    MoodCell(mood: moodEntry)
                    
                }
            }
            .listStyle(PlainListStyle())
            .onChange(of: newMoodValue, perform: { value in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }) // Permet de rafraichir la liste quand on ajoute un nouvel état de forme
            
        }
        
    }
}
extension UserDefaults {
  static let group = UserDefaults(suiteName: "group.bonum")!
}


struct MoodTracker_Previews: PreviewProvider {
    
    static var previews: some View {
        MoodTracker()
            .environmentObject(UserData(name: "Albert", userElementsList: MYELEMENTS, userJourneyEvents: MYJOURNEY, userMoodHistory: MYMOODS))
    }
}


// Extension permettant de stocker une date dans les userdefaults (via @AppStorage) en rendant Date conforme à RawRepresentable
extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

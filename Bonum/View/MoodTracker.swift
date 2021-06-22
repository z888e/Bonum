//
//  MoodTracker.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//
// !!!! Ajouter JOKER + Source de l'affichage du mood tracker + new look

import SwiftUI
import WidgetKit

struct MoodTracker: View {
    
    @EnvironmentObject var userData: UserData
    @State private var scoreEntered : Int = 0
    // Permet de stocker le dernier score et sa date
    @AppStorage("lastMoodRating") private var lastMoodRating: Int = 5
    @AppStorage("lastMoodDate") private var lastMoodDate: Date = Date()
    @State private var newMoodValue: MoodValue = MoodValue(timestamp: Date(), rating: 0, source: 0)
    
    let noticationManager = NotificationDelegate()
    
    let dateW = UserDefaults.group.object(forKey: "dateW") as? String ?? "No date"
    
    //    var lastMood: Int {
    //        return userData.userMoodHistory.last?.rating ?? 0
    //    }
    
    // Pour afficher l'historique par date de saisie la plus récente
    var sortedMoodHistory: [MoodValue] {
        return userData.userMoodHistory.sorted {
            $0.timestamp > $1.timestamp
        }
    }
    
    //    init() {
    //        self.lastMood = userData.userMoodHistory[1].rating ?? 0
    //    }
    
    var body: some View {
        
        VStack {
            
            Image("forme8")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
            
            //            VStack{
            
            WheelButton(totAngle: 270, scale: 1.5, initValue: lastMoodRating, scoreEntered: $scoreEntered)
                .onChange(of: scoreEntered, perform: { value in
                    
                    newMoodValue = MoodValue(timestamp: Date(), rating: lastMoodRating, source: 0)
                    userData.userMoodHistory.append(newMoodValue)
                    userData.writeJson(tab: userData.userMoodHistory, filename: "MoodsList")
                    UserDefaults.group.set(dateToString(date: Date()), forKey: "dateW")
                    lastMoodDate = Date()
                    lastMoodRating = lastMoodRating
                    
                    // Réinitialisation des notifications
                    noticationManager.smartNotification(lastEnreg: Date(), interval: 75)
                    
                    // Refresh du widget (ne pas oublier d'importer WidgetKit)
                    WidgetCenter.shared.reloadTimelines(ofKind: "BonumWidget")
                    
                })
                .frame(maxWidth: UIScreen.main.bounds.width, minHeight: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            List {
                ForEach(sortedMoodHistory, id: \.self) { moodEntry in
                    MoodCell(mood: moodEntry)
                        .listRowInsets(.init(top: 0, leading: 1, bottom: 1, trailing: 1))
                }
            }
            
        }
        
    }
}
extension UserDefaults {
    static let group = UserDefaults(suiteName: "group.bonum")!
}


struct MoodTracker_Previews: PreviewProvider {
    
    static var previews: some View {
        let userData = UserData(name: "Albert", userElementsList: MYELEMENTS, userJourneyEvents: MYJOURNEY, userMoodHistory: MYMOODS)
        
        MoodTracker()
            .environmentObject(userData)
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

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
    @Binding var showMoodTracker: Bool
    // Permet de stocker le dernier score et sa date
    @AppStorage("lastMoodRating") private var lastMoodRating: Int = 0
    @AppStorage("lastMoodDate") private var lastMoodDate: Date = Date()
    @State private var newMoodValue: MoodValue = MoodValue(timestamp: Date(), rating: 0, source: 0)
    @State private var showHistory: Bool = false
    @State private var newClic : Bool = false
    var lastMoodForMr: Int {
        lastMoodRating
    }
    
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
        
        ZStack{
            Color("AppColorWhite")
            
        VStack {
            
            Spacer().frame(height: 40)
            
            Text("Quelle est votre état de forme en ce moment ?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("AppColor3"))
                .multilineTextAlignment(.center)
                .padding(  )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("AppColor1"), lineWidth: 1).shadow(color: Color("AppColor1"), radius: 3.0, x: -2, y: 2)
                )

            
        Spacer().frame(height: 220)
            
//            Image("forme8")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .padding()

            
            WheelButton(totAngle: 270, scale: 1.5, initValue: lastMoodRating, newClic: $newClic)
                .onChange(of: newClic, perform: { value in
                    
                    newMoodValue = MoodValue(timestamp: Date(), rating: lastMoodRating, source: 0)
                    userData.userMoodHistory.append(newMoodValue)
                    userData.writeJson(tab: userData.userMoodHistory, filename: "MoodsList")
                    UserDefaults.group.set(dateToString(date: Date(), format: "DateTimeShort"), forKey: "dateW")
                    lastMoodDate = Date()
                    lastMoodRating = lastMoodRating
                    
                    // Réinitialisation des notifications
                    noticationManager.smartNotification(lastEnreg: Date(), interval: 75)
                    
                    // Refresh du widget (ne pas oublier d'importer WidgetKit)
                    WidgetCenter.shared.reloadTimelines(ofKind: "BonumWidget")
                    
                    // Fermeture de la modale
                    showMoodTracker = false
                    
                })
                .frame(maxWidth: UIScreen.main.bounds.width, minHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: {showMoodTracker = false}, label: {
                    Text("Annuler")
            })
            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                
            Spacer().frame(height: 100)
            
            Button(action: {showHistory = true}, label: {
                VStack{
                    Image(systemName: "clock")
                    Text("Historique")
                    }
            })
            Spacer()
            
        }
        .sheet(isPresented: $showHistory, content: {
            Button("Fermer l'historique") {
                self.showHistory.toggle()
            }
            .padding()
            ScrollView {
                ForEach(sortedMoodHistory, id: \.self) { moodEntry in
                    MoodCell(mood: moodEntry)
                }
            }
        })
        
        }
        .ignoresSafeArea()
    }
}
extension UserDefaults {
    static let group = UserDefaults(suiteName: "group.bonum")!
}


struct MoodTracker_Previews: PreviewProvider {
    
    static var previews: some View {
        let userData = UserData(name: "Albert", userElementsList: MYELEMENTS, userJourneyEvents: MYJOURNEY, userMoodHistory: MYMOODS)
        
        MoodTracker(showMoodTracker: .constant(true))
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

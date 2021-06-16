//
//  UserNotifications.swift
//  Bonum
//
//  Created by Wilfried Roguet on 15/06/2021.
//
/* INSERER CECI :
 UserNotifications()
 .onOpenURL(perform: { url in
 print("Incoming URL : \(url)")
 })
 */

import SwiftUI
import UserNotifications // Ne pas oublier la librairie

struct UserNotifications: View {
    
    @State private var authMessage: String = "Test sur \"Notifications autorisées\" non fait"
    
    @State private var beginHour: String = "8"
    @State private var endHour: String = "18"
    @State private var timer: String = "240"
    @State private var test: Double = 1000000.0
    @State private var dateEnreg = Date()
    
    /// instanciation d'une class avec le protocol UNUserNotificationCenterDelegate afin de déléguer au NotificationCenter certaines actions depuis les notifications
    let noticationManager = NotificationDelegate()
    let center = UNUserNotificationCenter.current()
    
    var body: some View {
        
        VStack {
            
            /// Demande à l'utilisateur s'il accepte les notifications et affiche le résultat
            Text(authMessage)
                .fontWeight(.bold)
                .onAppear{
                    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                        if granted {
                            authMessage = "👍 Notifications autorisées"
                            noticationManager.scheduleNotification()
                        } else {
                            authMessage = "👎 Notifications non autorisées"
                        }
                    }
                }
                .font(.title2)
            
/*
            HStack{
                Text("A partir de quelle heure voulez-vous être notifié chaque jour ?")
                TextField("Heure de début", text: $beginHour)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
            }
            
            HStack{
                Text("A partir de quelle heure voulez-vous être notifié chaque jour ?")
                TextField("Heure de fin", text: $endHour)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
            }
            
            HStack{
                Text("A quelle fréquence souhaitez-vous recevoir les relances ?")
                TextField("Délai de relance", text: $timer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
            }
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Réinitialiser les relances périodiques")                .fontWeight(.semibold)
                    .frame(width: 330, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(12)
                    .foregroundColor(.white)
            })
            
            HStack{
                Button(action: {dateEnreg = Date()}, label: {
                    Text("Simuler un enregistrement -> \(dateEnreg, style: .timer)")                .fontWeight(.semibold)
                        .frame(width: 330, height: 50)
                        .background(Color.red)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                })
            }
            .padding(.top)
           
                Text("Date de dernière enregistrement : ")
            Text(chronoFromEnreg(previousEnreg: dateEnreg))
            Text("Temps écoulé depuis : ")
            Text("\(dateEnreg.timeIntervalSinceNow)")
            
*/
        }
        .padding()
    }
}

func chronoFromEnreg(previousEnreg: Date) -> String {
//    let today = Date()-previousEnreg
    let formatter1 = DateFormatter()
    formatter1.dateFormat = "d MMM y, HH:mm:ss"
//    formatter1.dateStyle = .medium
    return formatter1.string(from: previousEnreg)
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        //    center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        
        /// Le contenu de la notification: titre, body et catégorie (pour des regroupements)
        let content = UNMutableNotificationContent()
        content.title = "Forme du matin"
        content.body = "Bonum est impatient de savoir si vous êtes en forme aujourd'hui."
        // The notification request set a userInfo property on the notification, which is a dictionary where you can store any kind of context data you want.
        content.userInfo = ["customData": "bonumNotification"]
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "IDCat"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 30
        
        /// Le trigger défini quand la notification sera envoyée
        /// Option n°1 :avec dateMatching, elle sera envoyée à une heure précise (et tous les jours ici car repeats = true)
        //    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        /// Option n°2 pour tester :avec timeInterval, elle sera envoyée 5 secondes après sa planification (et une seule fois ici)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        
        // Each action must be created using a uid and title
        let openMoodAction = UNNotificationAction(identifier: "IDActionMood", title: "Estimer sa forme", options: .foreground)
        let openProgressAction = UNNotificationAction(identifier: "IDActionProgress", title: "Voir sa progression", options: .foreground)
        
        // Actions are put into categories, which can be used to organized each of the notification actions
        let meetingNotificationCategory = UNNotificationCategory(identifier: "IDCat", actions: [openMoodAction, openProgressAction], intentIdentifiers: [])
        
        /// La requête qui englobe le quoi et le quand
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Call this method before UNUserNotificationCenter.current().add
        center.setNotificationCategories([meetingNotificationCategory])
        
        center.add(request)
    }
    
    func smartNotification(lastEnreg: Int) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Evaluation de la forme"
        content.body = "Vous n'avez pas évalué votre forme depuis \(lastEnreg). Voulez-vous le faire ?"
        content.userInfo = ["customData": "bonumSartNotification"]
        content.sound = UNNotificationSound.default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // the user swiped to unlock
            print("Default identifier")
            
        case "IDActionMood":
            // the user tapped our "show more info…" button
            print("Estimer sa forme…")
            break
            
        case "IDActionProgress":
            // the user tapped our "show more info…" button
            print("Montrer les progès…")
            break
            
        default:
            break
        }
        
        // you must call the completion handler when you're done
        completionHandler()
    }
}




struct UserNotifications_Previews: PreviewProvider {
    static var previews: some View {
        UserNotifications()
    }
}

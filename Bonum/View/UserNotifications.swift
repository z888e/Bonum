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
    
    let center = UNUserNotificationCenter.current()
    @State private var authMessage: String = "Test sur \"Notifications autorisées\" non fait"
    
    var body: some View {
        
        /// Demande à l'utilisateur s'il accepte les notification et affiche le résultat
        Text(authMessage)
            .onAppear{
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if granted {
                        authMessage = "👍 Notifications autorisées"
                        scheduleNotification()
                    } else {
                        authMessage = "👎 Notifications non autorisées"
                    }
                }
            }
    }
}

func scheduleNotification() {
    let center = UNUserNotificationCenter.current()
    
   /// Le contenu de la notification: titre, body et catégorie (pour des regroupements)
    let content = UNMutableNotificationContent()
    content.title = "Forme du matin"
    content.body = "Bonum est impatient de savoir si vous êtes en forme aujourd'hui."
    content.categoryIdentifier = "alarm"
    /// The notification request set a userInfo property on the notification, which is a dictionary where you can store any kind of context data you want.
    content.userInfo = ["customData": "bonum"]
    content.sound = UNNotificationSound.default

    var dateComponents = DateComponents()
    dateComponents.hour = 8
    dateComponents.minute = 30
    
    /// Le trigger défini quand la notification sera envoyée
    /// Option n°1 :avec timeInterval, elle sera envoyée 5 secondes après sa planification (et une seule fois ici)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    /// Option n°2 :avec dateMatching, elle sera envoyée à une heure précise (et tous les jours ici car repeats = true)
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    /// La requête qui englobe le quoi et le quand
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    
    // Each action must be created using a uid and title
    let openMoodAction = UNNotificationAction(identifier: "uniqueActionIDGoesHere", title: "Estimer sa forme", options: .foreground)
    let openProgressAction = UNNotificationAction(identifier: "uniqueActionIDGoesHere", title: "Voir sa progression", options: .foreground)

    // Actions are put into categories, which can be used to organized each of your notification actions
    let meetingNotificationCategory = UNNotificationCategory(identifier: "uniqueCategoryIDGoesHere", actions: [openMoodAction, openProgressAction], intentIdentifiers: [])

    // Call this method before UNUserNotificationCenter.current().add
    center.setNotificationCategories([meetingNotificationCategory])
    
    
 
    center.add(request)
}



/* CE QUI SUIT REQUIERE UN PRTOCOL QUE JE N'ARRIVE PAS à METTRE EN OEUVRE
 
 /// To set self to be the delegate for the notification center, so you’ll need to make your view controller conform to the UNUserNotificationCenterDelegate protocol.
func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self

    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

    center.setNotificationCategories([category])
}

func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // pull out the buried userInfo dictionary
    let userInfo = response.notification.request.content.userInfo

    if let customData = userInfo["customData"] as? String {
        print("Custom data received: \(customData)")

        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // the user swiped to unlock
            print("Default identifier")

        case "show":
            // the user tapped our "show more info…" button
            print("Show more information…")
            break

        default:
            break
        }
    }

    // you must call the completion handler when you're done
    completionHandler()
}
 
*/


struct UserNotifications_Previews: PreviewProvider {
    static var previews: some View {
        UserNotifications()
    }
}

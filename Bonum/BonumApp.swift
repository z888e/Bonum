//
//  BonumApp.swift
//  Bonum
//
//  Created by Zoé Hartman on 10/06/2021.
//

import SwiftUI

@main
struct BonumApp: App {
    
    @StateObject var userData = UserData(name: "Albert", userElementsList: MYELEMENTS, userJourneyEvents: MYJOURNEY, userMoodHistory: MYMOODS2)
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userData)
//            UserNotifications()
        }
    }
}

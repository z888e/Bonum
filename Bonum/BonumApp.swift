//
//  BonumApp.swift
//  Bonum
//
//  Created by Zoé Hartman on 10/06/2021.
//

import SwiftUI

@main
struct BonumApp: App {
    
    @StateObject var healthStore = HealthStoreData()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(healthStore)
//            UserNotifications()
        }
    }
}

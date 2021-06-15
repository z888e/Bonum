//
//  ContentView.swift
//  Bonum
//
//  Created by Zoé Hartman on 10/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    // Permet d'afficher l'onboarding au premier démarrage seulement
//    @State private var isOnboardingShowing = UserDefaults.standard.bool(forKey: "isOnboardingShowing")
    @State private var isOnboardingShowing = true
    
    var body: some View {

        if isOnboardingShowing {
            Onboarding(isOnboardingShowing: $isOnboardingShowing)
        } else {
            Diary()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

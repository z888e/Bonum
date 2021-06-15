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
    // Permet de stocker le nom de l'utilisateur
    @State var userName: String = UserDefaults.standard.string(forKey: "name") ?? ""
    
    var body: some View {

        if isOnboardingShowing {
            Onboarding(isOnboardingShowing: $isOnboardingShowing, userName: $userName)
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

//
//  ContentView.swift
//  Bonum
//
//  Created by Zoé Hartman on 10/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    // Permet d'afficher l'onboarding au premier démarrage seulement
    @AppStorage("isOnboardingShowing") private var isOnboardingShowing: Bool = true
    
    // Permet de stocker le nom de l'utilisateur
    @AppStorage("userName") private var userName: String = ""
    
    var body: some View {
            
            if isOnboardingShowing {
                Onboarding(isOnboardingShowing: $isOnboardingShowing, userName: $userName)
            } else {
                TabBarView()
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




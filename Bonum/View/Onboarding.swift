//
//  Onboarding.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Onboarding: View {
    
    @Binding var isOnboardingShowing: Bool
    @Binding var userName: String
    
    // l'étape à afficher à l'écran
    @State var currentStep: Int = 0
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            VStack {
                Text("Bonjour !")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                
                Text("Ravis de voir que vous prenez votre forme en main.")
                    .font(.title3)
                    .padding()
                
                Text("Bonum va vous permettre de suivre l'évolution de votre état de forme et de la comparer à de multiples données.")
                    .font(.title3)
                    .padding()
            }
            
//            PageTab(userName: $userName, currentStep: $currentStep)
            
//            Buttons(currentStep: $currentStep, isOnboardingShowing: $isOnboardingShowing)
            
            Button(action: {
                    isOnboardingShowing = false
            }, label: {
                Text("Commencer")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(width: 150, height: 44)
                    .background(Color.accentColor)
                    .cornerRadius(12)
            })
            
        }
        .padding()
        .multilineTextAlignment(.center)
        
    }

}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(isOnboardingShowing: .constant(true), userName: .constant(""))
    }
}

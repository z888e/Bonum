//
//  Onboarding.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Onboarding: View {
    
    @Binding var isOnboardingShowing: Bool
    
    // l'étape à afficher à l'écran
    @State var currentStep: Int = 0
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            PageTab(currentStep: $currentStep)
            
            Buttons(currentStep: $currentStep)
            
        }
        .transition(.move(edge: .bottom))
        .padding()
        .multilineTextAlignment(.center)
        
    }

}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(isOnboardingShowing: .constant(true))
    }
}

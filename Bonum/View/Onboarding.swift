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
        
        VStack {
            
            Spacer()

            VStack {
                Text("Bonjour !")
                    .font(.title)
                    .foregroundColor(Color("AppColorWhite"))
                    .fontWeight(.semibold)
                    .padding(.vertical, 50)
                
                Text("Ravis de voir que vous prenez votre forme en main.")
                    .font(.title3)
                    .foregroundColor(Color("AppColorWhite"))
                    .padding()
                
                Text("Bonum va vous permettre de suivre l'évolution de votre état de forme et de la comparer à de multiples données.")
                    .font(.title3)
                    .foregroundColor(Color("AppColorWhite"))
                    .padding()
            }
            
            Spacer()
            
            Button(action: {
                    isOnboardingShowing = false
            }, label: {
                Text("Commencer")
                    .foregroundColor(Color("AppColorWhite"))
                    .fontWeight(.semibold)
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(Color("AppColor1"))
                    .cornerRadius(20)
                    .shadow(radius: 1)
            })
            
            Spacer()
            
            
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(Color("AppColor3"))
        .edgesIgnoringSafeArea(.top)
        
    }

}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(isOnboardingShowing: .constant(true), userName: .constant(""))
    }
}

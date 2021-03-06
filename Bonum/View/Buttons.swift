//
//  Buttons.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 15/06/2021.
//

import SwiftUI

struct Buttons: View {
    
    @Binding var currentStep: Int
    @Binding var isOnboardingShowing: Bool
    let buttons = ["Précédent", "Suivant"]
    
    var body: some View {
        
        HStack {
            ForEach(buttons, id: \.self) { buttonLabel in
                
                Button(action: { buttonAction(buttonLabel) }, label: {
                    Text(buttonLabel)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 150, height: 44)
                        .background(Color("AppColor1"))
                        .cornerRadius(12)
                })
                
            }
        }
        .foregroundColor(Color("AppColorWhite"))
        .padding()

    }
    
    func buttonAction(_ buttonLabel: String) {

        withAnimation {
            if buttonLabel == "Précédent" && currentStep > 0 {
                currentStep -= 1
            } else if buttonLabel == "Suivant" && currentStep < 3 {
                currentStep += 1
            } else if buttonLabel == "Suivant" && currentStep == 3 {
                isOnboardingShowing = false
            }
        }

    }
    
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons(currentStep: .constant(0), isOnboardingShowing: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}

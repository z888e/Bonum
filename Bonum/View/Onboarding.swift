//
//  Onboarding.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Onboarding: View {
    
//    @AppStorage("name") var userName: String = ""
    @State var currentStep: Int = 1
    var progress: Double {
        Double(currentStep) / 5
    }
    var buttonLabel: String {
        if currentStep == 5 {
            return "Commencer"
        } else {
            return "Suivant"
        }
    }
    @State var userName: String = ""
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Spacer()
            
            // TODO: extraire le texte des écrans pour éviter les redondances
            
            if currentStep == 1 {
                
                Text("Bonjour !")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                
                Text("Ravis de voir que vous prenez votre forme en main.")
                    .font(.title3)
                    .padding()
                
                Text("Bonum va vous permettre de suivre l'évolution de votre état de forme et de la comparer à de multipler données.")
                    .font(.title3)
                    .padding()
                
            } else if currentStep == 2 {
                
                Text("Comment dois-je vous appeler ?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                TextField("Votre nom", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    
                    UserDefaults.standard.set(userName, forKey: "name")
                    currentStep += 1
                }) {
                    Text("Sauvegarder")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                }
                .padding()
                
            } else if currentStep == 3 {
                
                Text("Quelle donnée de forme souhaitez-vous suivre, \(userName) ?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                Button(action: {
                    currentStep += 1
                }) {
                    Text("Utiliser une donnée Santé")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                }
                .padding()
                
                Button(action: {
                    currentStep += 1
                }) {
                    Text("Saisir manuellement")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                }
                .padding()
                
                // bouton qui déclenche une modale, qui affiche la liste de toutes les données pouvant être suivies (la liste est récupérée depuis Apple Santé)
                
            } else if currentStep == 4 {
                
                Text("Bravo, vous pourrez ajouter par la suite d'autres données à suivre.")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
            } else if currentStep == 5 {
                
                
                
            }
            
            Spacer()
            
            HStack {
                // TODO: ne pas afficher le bouton Précédent à la première étape
                // TODO : désactiver bouton Suivant (.disabled) si données obligatoires non renseignées
                
                Button(action: {
                    currentStep -= 1
                }) {
                    Text("Précédent")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                }
                .padding()
                
                Button(action: {
                    currentStep += 1
                }) {
                    Text(buttonLabel)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                }
                .padding()
            }
            

            ProgressView(value: progress)
                .padding()
            
            Spacer()
        }
        .padding()
        .multilineTextAlignment(.center)
//        .onAppear {
//            userName = User
//        }
        
    }

}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(currentStep: 1)
    }
}

//
//  PageTab.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 15/06/2021.
//

import SwiftUI

struct PageTab: View {
    
    @Binding var currentStep: Int
    @State var userName: String = UserDefaults.standard.string(forKey: "name") ?? ""
    
    var body: some View {
        
        TabView(selection: $currentStep) {
            
            VStack {
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
            }
            .tag(0)
            
            VStack {
                Text("Comment dois-je vous appeler ?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                TextField("Votre nom", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .tag(1)
            
            VStack {
                Text("Quelle donnée de forme souhaitez-vous suivre, \(userName) ?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                Button(action: {
                    
                }) {
                    Text("Utiliser une donnée Santé")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 250, height: 44)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(12, antialiased: true)
                        .padding(.horizontal)
                }
                .padding()
                
                Button(action: {
                    
                }) {
                    Text("Saisir manuellement")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 250, height: 44)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(12, antialiased: true)
                        .padding(.horizontal)
                }
                .padding()
            }
            .tag(2)
            
            VStack {
                Text("Bravo, vous pourrez ajouter par la suite d'autres données à suivre.")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
            }
            .tag(3)
            
        }
        .padding()
        .multilineTextAlignment(.center)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
    }
}

struct PageTab_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PageTab(currentStep: .constant(0))
            PageTab(currentStep: .constant(1))
            PageTab(currentStep: .constant(2))
            PageTab(currentStep: .constant(3))
        }
    }
}

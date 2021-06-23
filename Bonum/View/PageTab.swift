//
//  PageTab.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 15/06/2021.
//

import SwiftUI

struct PageTab: View {
    
    @Binding var userName: String
    @Binding var currentStep: Int
    
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
                
                Text("Bonum va vous permettre de suivre l'évolution de votre état de forme et de la comparer à de multiples données.")
                    .font(.title3)
                    .padding()
            }
            .tag(0)
            
            VStack {
                Text("Comment dois-je vous appeller ?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                TextField("Votre nom", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .tag(1)
            
            VStack {
                Text("\(userName), quelle donnée de forme souhaitez-vous suivre pour commencer ?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                Button(action: {
                    
                }) {
                    Text("Une donnée depuis Santé")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 300, height: 44)
                        .foregroundColor(Color("AppColorWhite"))
                        .background(Color.gray)
                        .cornerRadius(12, antialiased: true)
                        .padding(.horizontal)
                }
                .padding()
                
                Button(action: {
                    
                }) {
                    Text("Une donnée saisie manuellement")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 300, height: 44)
                        .foregroundColor(Color("AppColorWhite"))
                        .background(Color.gray)
                        .cornerRadius(12, antialiased: true)
                        .padding(.horizontal)
                }
                .padding()
            }
            .tag(2)
            
            VStack {
                Text("Bravo \(userName),\n\nVous pourrez ajouter par la suite d'autres données à suivre.\nMais pour commencer, nous allons estimer ensemble votre niveau de forme du moment !")
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
            PageTab(userName: .constant("Alex"), currentStep: .constant(0))
            PageTab(userName: .constant("Alex"), currentStep: .constant(1))
            PageTab(userName: .constant("Alex"), currentStep: .constant(2))
            PageTab(userName: .constant("Alex"), currentStep: .constant(3))
        }
    }
}

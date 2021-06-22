//
//  DiaryListDetails.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryListDetails: View {
    
    @EnvironmentObject var userData : UserData
    @State private var showingAlert = false
    
    var element : DataElement
    var index : IndexSet.ArrayLiteralElement
    var impactMessageToUser : String {
        var res = " "
        if element.impact == 0 {
            res = """
Impact indéterminé.
Suivez cet élement plus longtemps.
"""
        }else if element.impact > 0 && element.impact < 1 {
            res = "L'impact sur votre forme semble très faible."
        }else if element.impact >= 1 && element.impact < 2  {
            res = "L'impact sur votre forme semble faible."
        }else if element.impact >= 2 && element.impact < 3  {
            res = "L'impact sur votre forme semble moyen."
        }else if element.impact >= 3 && element.impact < 4  {
            res = """
L'impact sur votre forme semble fort.
Continuez !
"""
        }else if element.impact >= 4 && element.impact <= 5  {
            res = """
L'impact semble sur votre forme semble maximal.
Bravo, continuez !
"""
        }
        return res
    }

    var impactMessageColor : Color {
        var res : Color = .white
        if element.impact == 0 {
            res = .gray
        }else if element.impact > 0 && element.impact < 1 {
            res = .purple
        }else if element.impact >= 1 && element.impact < 2  {
            res = .blue
        }else if element.impact >= 2 && element.impact < 3  {
            res = .green
        }
        return res
    }
    
    func delete(at offsets: IndexSet) {
        userData.userElementsList.remove(atOffsets: offsets)
        userData.writeJson(tab: userData.userElementsList, filename: "ElementsList")
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:30){
                Text(element.customName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                HStack{
                    Text(impactMessageToUser)
                }.padding(20)
                .background(impactMessageColor)
                .cornerRadius(20)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.2)
                )
                
                DiaryListDetailsGraph(element : element)
                
                Spacer()
                
                Button(action: {
                    showingAlert = true
                }) {
                    HStack{
                        Text("Ne plus suivre cet élément")
                    }.padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray)
                    .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray, lineWidth: 2))
                    //                    .overlay(
                    //                        RoundedRectangle(cornerRadius: 25)
                    //                            .stroke(Color.gray, lineWidth: 0.2)
                    //                    )
                }
                .alert(isPresented: self.$showingAlert) {
                    Alert(title: Text("Interrompre le suivi"), message:   Text("""
Bonum n'utilisera plus cet élément pour aider votre forme. Les données resteront dans Santé.
"""), primaryButton: .destructive(Text("Supprimer")) {
    print("Deleting...")
    delete(at: [index])
},
                          secondaryButton: .cancel(Text("Annuler")))
                }.buttonStyle(PlainButtonStyle())
                .padding(.bottom, 70)
                
            }
            
        }
    }
}

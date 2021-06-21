//
//  DiaryListDetails.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryListDetails: View {
    
    @EnvironmentObject var userData : UserData
    var element : DataElement
    var index : IndexSet.ArrayLiteralElement
    
    func delete(at offsets: IndexSet) {
        userData.userElementsList.remove(atOffsets: offsets)
        userData.writeJson(tab: userData.userElementsList, filename: "ElementsList")
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:30){
                Text(element.customName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                Text("impact niveau" + String(element.impact))
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 0.2)
                    )
                
                Text("Graphique/Analyse de la variable suivie")
//                List(element, id: \.id){ el in
//
//                    VStack{
//                        Text("\(el.count)")
//                        Text(el.date, style: .date)
//                            .opacity(0.5)
//                    }
//
//                }
                
                Spacer()
                
                Button {
                    delete(at: [index])
                } label: {
                    HStack{
                        Text("Supprimer cet élément")
                        Image(systemName: "trash").font(.system(size: 20.0))
                    }.padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.red)
                    .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.red, lineWidth: 2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 0.2)
                    )
                }.buttonStyle(PlainButtonStyle())
            }
            
        }
    }
}

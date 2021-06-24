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
Impact indéterminé. Suivez cet élement plus longtemps.
"""
        }else if element.impact > 0 && element.impact < 1 {
            res = "L'impact sur votre forme est probable."
        }else if element.impact >= 1 && element.impact < 2  {
            res = """
L'impact sur votre forme semble fort. Continuez !
"""        }else if element.impact >= 2 && element.impact < 3  {
    res = """
L'impact semble sur votre forme semble maximal. Bravo, continuez !
"""        }
        return res
    }
    
    var impactMessageColor : Color {
        var res : Color = Color("AppColorWhite")
        if element.impact == 0 {
            res = .gray
        }else if element.impact > 0 && element.impact < 1 {
            res = .gray
        }else if element.impact >= 1 && element.impact < 2  {
            res = Color.yellow
        }else if element.impact >= 2 && element.impact < 3  {
            res = Color("AppColor1")
        }
        return res
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left")
                .foregroundColor(Color("AppColor3"))
            Text("Journal")
                .foregroundColor(Color("AppColor3"))
        }
    }
    }
    
    func delete(at offsets: IndexSet) {
        userData.userElementsList.remove(atOffsets: offsets)
        userData.writeJson(tab: userData.userElementsList, filename: "ElementsList")
    }
    
    var body: some View {
        
        VStack(spacing:0){
            HStack{
                btnBack.padding(20).padding(.top, 40)
                Spacer()
            }.background(Color("AppColorWhite"))
            
            ScrollView{
                VStack(spacing:30){
                    Text(element.customName)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("AppColor3"))
                        .padding(.vertical, 50)
                        .padding(.horizontal, 25)
                    
                    HStack{
                        Text(impactMessageToUser)
                            .foregroundColor(Color("AppColor3"))
                    }.padding(20)
                    
                    DiaryListDetailsGraph(element : element)
                    
                    Spacer()
                    
                    Button(action: {
                        showingAlert = true
                    }) {
                        HStack{
                            Text("Ne plus suivre cet élément")
                        }.padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .foregroundColor(Color("AppColor3"))
                        .overlay(RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("AppColor3"), lineWidth: 2))
                        
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
                }.background(Color("AppColorWhite"))
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }.edgesIgnoringSafeArea(.top)
    }
}

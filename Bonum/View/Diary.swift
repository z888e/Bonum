//
//  Diary.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Diary: View {
    
    @EnvironmentObject var userData: UserData    
    @State private var showingAddForm = false
    
    //mène à rien
    @State private var timeArea : String = "J"
    var allTimes = ["J", "S", "M", "A"]
    
    var body: some View {
        NavigationView{
            VStack{
                //TODO: Switch J/S/M/A
                Picker("", selection: $timeArea) {
                    ForEach(allTimes, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
                
                HStack{
                    Text("Aujourd'hui,").font(.title)
                        .padding()
                    Spacer()
                    
                    Button(action: {
                        showingAddForm = true
                    }) {
                        Image(systemName: "plus")
                            .font(Font.system(.title))
                            .foregroundColor(.orange)
                            .padding()
                    }.sheet(isPresented: $showingAddForm) {
                        AddElement()
                    }
                    
                }
                
                //TODO : display score calculé
                ScoreBonum().padding(.vertical, 20)
                
                ScrollView{
                    VStack(spacing: 20){
                        ForEach(Array(userData.userElementsList.enumerated()), id: \.1.id) {index, el in
                            
                            NavigationLink(
                                destination: DiaryListDetails(element: userData.userElementsList[index], index: index),
                                label: {
                                    ZStack{
                                        DiaryListCell(element: userData.userElementsList[index])
                                    }
                                }
                            )
                        }
                    }.padding(.horizontal, 20)
                    .foregroundColor(Color.black)
                }
            }.navigationBarHidden(true)
            .navigationTitle("Journal")
        }
    }
}

//struct Diary_Previews: PreviewProvider {
//    static var previews: some View {
//        Diary()
//    }
//}

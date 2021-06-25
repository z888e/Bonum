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
    @State private var timeArea : String = "J"
    var allTimes = ["J", "S", "M", "A"]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("AppColor1"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("AppColorWhite"))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("AppColor1"))], for: .normal)
    }
    
    var sortedElements: [DataElement] {return userData.userElementsList.sorted{$0.impact>$1.impact}}
    
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                ZStack{
                    Color("AppColor3")
                    VStack{
                        Picker("", selection: $timeArea) {
                            ForEach(allTimes, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 20)
                        .padding(.top, 40)
                        
                        HStack{
                            if timeArea == "J"{
                                Text("Aujourd'hui,").font(.title).foregroundColor(Color("AppColorWhite"))
                            }
                            if timeArea == "S"{
                                Text("Cette semaine,").font(.title).foregroundColor(Color("AppColorWhite"))
                            }
                            if timeArea == "M"{
                                Text("Ce mois,").font(.title).foregroundColor(Color("AppColorWhite"))
                            }
                            if timeArea == "A"{
                                Text("Cette année,").font(.title).foregroundColor(Color("AppColorWhite"))
                            }
                            
                            Spacer()
                            //                    PopulateHK()
                            
                            Button(action: {
                                showingAddForm = true
                            }) {
                                Image(systemName: "plus")
                                    .font(Font.system(.title))
                                    .foregroundColor(Color("AppColor1"))
                                    .padding()
                            }.sheet(isPresented: $showingAddForm) {
                                AddElement()
                            }
                            
                        }.padding(.leading,20)
                        
                        //TODO : display score calculé
                        ScoreBonum(timeArea : timeArea).padding(.bottom, 20)
                    }
                }
                
                ZStack{
                    VStack{
                        //couleur du top part du journal
                        Color("AppColor3")
                        //coueur du bottom part du journal
                        Color("AppColorWhite")
                    }
                    //coueur du bottom part du journal
                    RoundedRectangle(cornerRadius: 28).foregroundColor(Color("AppColorWhite"))
                    ScrollView{
                        VStack(spacing: 20){
                            ForEach(Array(sortedElements.enumerated()), id: \.1.id) {index, el in
                                
                                NavigationLink(
                                    destination: DiaryListDetails(element: sortedElements[index], timeArea: timeArea, index: index),
                                    label: {
                                        DiaryListCell(element: sortedElements[index], timeArea : timeArea)
                                    }
                                )
                            }
                        }.padding(.horizontal, 20)
                        .padding(.top, 21)
                        .padding(.bottom, 50)
                        //couleur du texte dans les cell
                        .foregroundColor(Color("AppColor3"))
                    }
                }
            }.navigationBarHidden(true)
            .navigationTitle("Journal")
            .edgesIgnoringSafeArea(.top)
        }
    }
}

//struct Diary_Previews: PreviewProvider {
//    static var previews: some View {
//        Diary()
//    }
//}

//
//  Diary.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Diary: View {
    
    @State var stepsVariable : DataElement = MYSTEPSELEMENT
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView{
            VStack{
                //TODO: Switch J/S/M/A
                
                //TODO: variables
                HealthKitOnboarding(stepsVariable: $stepsVariable)
                
                HStack{
                    Text("Aujourd'hui,").font(.title)
                        .padding()
                    Spacer()
                }
                
                //TODO : display score calculé
                ScoreBonum()
                
                List{
                    ForEach(Array(userData.userElementsList.enumerated()), id: \.1.id){
                        index, el in
                        
                        NavigationLink(
                            destination: DiaryListDetails(element:el),
                            label: {
                                DiaryListCell(element: el)
                            }
                        )
                    }
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

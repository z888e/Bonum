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
        VStack{
            HealthKitOnboarding(stepsVariable: $stepsVariable)
            Text("Bonjour, \(userData.name)")
            Text("Score Bonum ici")
            
            VStack{
                List{
                    ForEach(Array(userData.userElementsList.enumerated()), id: \.1.id){
                        index, el in
                        //TODO : Navlink
//                        DiaryListCell(element: userData.userElementsList[index])
                        DiaryListCell(element: el)
                    }
                }
            }
        }
    }
}

//struct Diary_Previews: PreviewProvider {
//    static var previews: some View {
//        Diary()
//    }
//}

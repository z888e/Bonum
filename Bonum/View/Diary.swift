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
            //TODO: variables
            HealthKitOnboarding(stepsVariable: $stepsVariable)
            Text("Bonjour, \(userData.name)")
            
            //TODO : display score calculé
            ScoreBonum()
                        
            //TODO: mettre dans son composant propre
            VStack{
                List{
                    ForEach(Array(userData.userElementsList.enumerated()), id: \.1.id){
                        index, el in
                        //TODO : Navlink marche pas
                        NavigationLink(
                            destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                            label: {
                                DiaryListCell(element: el)
                            }
                        )
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

//
////
////  DiaryList.swift
////  Bonum
////
////  Created by Zoé Hartman on 15/06/2021.
////
//
//import SwiftUI
//
//struct DiaryList: View {
//    
//    @EnvironmentObject var userData:UserData
//
//    var body: some View {
//        List(userData.userElementsList, id: \.id){ el in
//                
//                NavigationLink(
//                    destination: DiaryListDetails(),
//                    label: {
//                        DiaryListCell(element: el)
//                    })
//        
//            }
//        
//    }
//}
//
//struct DiaryList_Previews: PreviewProvider {
//    static var previews: some View {
//        DiaryList()
//    }
//}

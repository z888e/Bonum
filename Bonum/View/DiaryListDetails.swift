//
//  DiaryListDetails.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryListDetails: View {

    var element : DataElement

    var body: some View {
        VStack{
            Text(element.customName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Spacer()

            Text("impact niveau" + String(element.impact))
            Text("Graphique/Analyse de la variable suivie")
            Spacer()

        }
    }
}

struct DiaryListDetails_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListDetails(element: MYSTEPSELEMENT)
    }
}

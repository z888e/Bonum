
//
//  DiaryList.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryList: View {
    
    @Binding var steps : [DataValue]
    @EnvironmentObject var healthStore: HealthStoreData

    var body: some View {
            List(steps, id: \.id){ el in
                
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    label: {
                        DiaryListCell(displayedData: el)
                    })
        
            }
        
    }
}

struct DiaryList_Previews: PreviewProvider {
    static var previews: some View {
        DiaryList(steps: .constant(MYSTEPS))
    }
}

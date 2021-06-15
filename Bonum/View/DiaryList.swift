
//
//  DiaryList.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

struct DiaryList: View {
    
    @Binding var steps : [DataValue]

    var body: some View {
        NavigationView{
            List(steps, id: \.id){ el in
                
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    label: {
                        DiaryListCell(steps: $steps)
                    })
        
            }
        }
    }
}

struct DiaryList_Previews: PreviewProvider {
    static var previews: some View {
        DiaryList(steps: .constant(MYSTEPS))
    }
}

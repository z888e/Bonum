//
//  JourneyDetail.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct JourneyDetail: View {
    
    let event: JourneyEvent
    
    var body: some View {
        
        VStack {

            Text("\(event.title)")
            
        }
        .navigationTitle(event.title)

    }
    
}

struct JourneyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JourneyDetail(event: MYJOURNEY[0])
        }
    }
}

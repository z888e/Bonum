//
//  JourneyEdit.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 18/06/2021.
//

import SwiftUI

struct JourneyEdit: View {
    
//    @Binding var event: JourneyEvent
    
    @State private var JourneyData: JourneyEvent.Data = JourneyEvent.Data()
//    let event: JourneyEvent
    
    var body: some View {
        
        List {
            
            Circle()
                .frame(width: 60, height: 60)

            TextField("Titre", text: $JourneyData.title)
            DatePicker("Date", selection: $JourneyData.date)
            
        }
        
    }
    
}

struct JourneyEdit_Previews: PreviewProvider {
    static var previews: some View {
        JourneyEdit()
    }
}

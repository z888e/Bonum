//
//  Diary.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Diary: View {
    
    @State private var steps = [DataValue]()
    
    var body: some View {
        VStack{
            HealthKitOnboarding(steps: $steps)
            Text("Score Bonum ici")
            DiaryList(steps: $steps)
        }
    }
}

struct Diary_Previews: PreviewProvider {
    static var previews: some View {
        Diary()
    }
}

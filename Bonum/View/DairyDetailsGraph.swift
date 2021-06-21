//
//  DairyDetailsGraph.swift
//  Bonum
//
//  Created by Zoé Hartman on 21/06/2021.
//

import SwiftUI

struct DairyDetailsGraph: View {
    
    var element : DataElement
    
    var body: some View {
        VStack{
            ForEach(element.values, id: \.self){ el in
                Text(String(el.count))
                Text(dateToString(date: el.date))
            }
        }
        
    }
}

struct DairyDetailsGraph_Previews: PreviewProvider {
    static var previews: some View {
        DairyDetailsGraph(element: MYSTEPSELEMENT)
    }
}

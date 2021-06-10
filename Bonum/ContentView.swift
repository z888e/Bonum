//
//  ContentView.swift
//  Bonum
//
//  Created by Zoé Hartman on 10/06/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, team!")
                .padding()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Text("Salut, ici Alex !")
            Text("Salut, ici Thomas !")
            Text("Salut, ici Wil !")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

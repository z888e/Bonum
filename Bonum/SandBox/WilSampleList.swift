//
//  WilTest01.swift
//  Bonum
//
//  Created by Wilfried Roguet on 11/06/2021.
//
// Thomas

import SwiftUI

struct WilSampleList: View {
    
    @State private var hailActive: Bool = false
    @State private var thunderActive: Bool = false
    @State private var tropicalActive: Bool = false
    
    let hailUrl = URL(string: "weather://hail")
    let thunderUrl = URL(string: "weather://thunder")
    let tropicalUrl = URL(string: "weather://tropical")
    
    var body: some View {

        NavigationView {
              List {
                NavigationLink(destination: WilListDetail(imageName: "cloud.hail", textToDDisplay: "Pluvieux"),
                                 isActive: $hailActive) {
                      Label("Pluvieux", systemImage: "cloud.hail")
                  }
                
                NavigationLink(destination:  WilListDetail(imageName: "cloud.bolt.rain", textToDDisplay: "Orageux"),
                            isActive: $thunderActive) {
                      Label("Orageux", systemImage: "cloud.bolt.rain")
                  }
                  
                NavigationLink(destination: WilListDetail(imageName: "tropicalstorm", textToDDisplay: "Tempête tropicale"),
                            isActive: $tropicalActive) {
                      Label("Tempête tropicale", systemImage: "tropicalstorm")
                  }
              }
              .navigationTitle("Severe Weather")
              .onOpenURL(perform: { (url) in
                   self.hailActive = url == hailUrl
                   self.thunderActive = url == thunderUrl
                   self.tropicalActive = url == tropicalUrl
              })
          }
    
    }
}

struct WilSampleList_Previews: PreviewProvider {
    static var previews: some View {
        WilSampleList()
    }
}

//
//  BonumApp.swift
//  Bonum
//
//  Created by Zoé Hartman on 10/06/2021.
//

import SwiftUI

@main
struct BonumApp: App {
    var body: some Scene {
        WindowGroup {
            WilTest01()
                .onOpenURL { url in
                    print("Received deep link: \(url)")}
        }
    }
}

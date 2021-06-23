//
//  TabBarView.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI

//extension UITabBarController {
//    override open func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let standardAppearance = UITabBarAppearance()
////        standardAppearance.backgroundColor = UIColor(named: "TabColor")
//        tabBar.standardAppearance = standardAppearance
//    }
//}

struct TabBarView: View {
    
    var body: some View {
            TabView{
                Diary()
                   .tabItem {
                       Label("Journal", systemImage: "book.closed")
                   }

                MoodTracker(showMoodTracker: .constant(true))
                   .tabItem {
                    Label(" ", systemImage: "plus.circle")
                   }

                Journey()
                    .tabItem {
                        Label("Parcours", systemImage: "arrow.triangle.pull")
                    }
            }
//            .accentColor(Color.yellow)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

//
//  CustomTabBar.swift
//  Bonum
//
//  Created by Wilfried Roguet on 18/06/2021.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var tabIndex: Int
    
    let fontSize: CGFloat = 10
    let iconSize: CGFloat = 20
    let unselectetIconColor = Color.gray
    let selectetIconColor = Color.orange

    
    var body: some View {
        
        VStack{
            ZStack{
            
            switch tabIndex {
            case 0:
                Diary()
            case 1:
                MoodTracker()
            case 2:
                Journey()
            default:
                MoodTracker()
            }
            }
            .padding(.bottom, -24) // Je ne sais pas pq cette valeur marche...
            
            
            HStack{
                Button(action: {
                    self.tabIndex = 0
                }) {
                    VStack{
                        Image(systemName: "book.closed")
                            .font(.system(size: iconSize))
                        Text("Journal")
                            .font(.system(size: fontSize))
                    }
                }
                .foregroundColor(self.tabIndex == 0 ? selectetIconColor : unselectetIconColor)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    self.tabIndex = 1
                }) {
                    //            Image(systemName: "plus.circle")
                    PulsingButton(colorB: (self.tabIndex == 1 ? selectetIconColor : unselectetIconColor), sizeB: iconSize*3, minimumRatioB: 0.5, durationB: 0.5)
                }
                .offset(y: -iconSize*1.5)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    self.tabIndex = 2
                }) {
                    VStack{
                        Image(systemName: "arrow.triangle.pull")
                            .font(.system(size: iconSize))
                        Text("Parcours")
                            .font(.system(size: fontSize))
                    }
                }
                .foregroundColor(self.tabIndex == 2 ? selectetIconColor : unselectetIconColor)
                
            } // fin HStack
            .padding(.horizontal, 50.0)
            .background(Color.black.opacity(0.05))
            
        } // fin VStack
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(tabIndex: .constant(1))
    }
}

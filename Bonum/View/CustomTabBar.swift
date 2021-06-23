//
//  CustomTabBar.swift
//  Bonum
//
//  Created by Wilfried Roguet on 18/06/2021.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var tabIndex: Int
    @AppStorage("lastMoodDate") private var lastMoodDate: Date = Date()
    @State private var sinceLastMoodDate : Double = 1
    @State private var counter: Int = 0
    
    let fontSize: CGFloat = 12
    let iconSize: CGFloat = 28
    let unselectetIconColor = Color("AppColor3")
    let selectetIconColor = Color("AppColor1")
    let durations: [Double] = [5, 2, 1, 0.6, 0.3]
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
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
            .padding(.bottom, -8)  // NE MARCHE pas ds tous les cas
            
            
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
                    PulsingButton(colorB: (self.tabIndex == 1 ? selectetIconColor : unselectetIconColor), sizeB: iconSize*3.3, minimumRatioB: 0.5, durationB: durations[counter])
                        .onReceive(timer) { time in
                            if self.counter == 4 {
                                self.timer.upstream.connect().cancel()
                            } else {
                                self.counter += 1
                            }
                        } // permet d'accélérer la pulsation... pb : il faudrait aussi réinitialiser l'animation avant
                }
                .offset(y: -iconSize*1.6)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    self.tabIndex = 2
                }) {
                    VStack{
                        Image(systemName: "arrow.triangle.pull")
                            .font(.system(size: iconSize))
                        Text("Parcours")
                            .font(.system(size: fontSize))
                        //                        Text(String(sinceLastMoodDate))
                    }
                }
                .foregroundColor(self.tabIndex == 2 ? selectetIconColor : unselectetIconColor)
                
            } // fin HStack
            .padding(.horizontal, 45.0)
            //couleur de fond de la tabbar
            .background(Color("AppColor1").opacity(0.2))
            
        } // fin VStack
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(tabIndex: .constant(1))
            .environmentObject(UserData(name: "Albert", userElementsList: MYELEMENTS, userJourneyEvents: MYJOURNEY, userMoodHistory: MYMOODS))
    }
}

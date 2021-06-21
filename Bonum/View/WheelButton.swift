//
//  WilwheelButton.swift
//  Bonum
//
//  Created by Wilfried Roguet on 21/06/2021.
//

import SwiftUI
import AVFoundation

struct WheelButton: View {
    
    var totAngle: Double
    var scale : Double
    var colorPoints : Color
    var initValue : Int
    
    //    let anglePoints: [Double] = [-45, -15, 15, 45, 75, 105, 135, 165, 195, 225]
    var anglePoints: [Double] {
        let laps: Double = totAngle/9
        let start: Double = 90-totAngle/2
        var array: [Double] = [start]
        for i in 1...9 {
            array.append(start + Double(i) * laps)
        }
        return array
    }
    @State private var pressButton: Bool = false
    @State private var selectedValue: Int = 0
    @State private var selectedAngle: Double = 0
    
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    @AppStorage("lastMoodRating") private var lastMoodRating: Int = 5
    
    @Binding var scoreEntered: Int

    
    var body: some View {
        ZStack{
            
            // La bague autour
            Image("moletteM")
                .resizable()
                .rotationEffect(.degrees(54))
                .frame(width: 123, height: 123, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            // Le bouton du milieu
            Image("moletteS")
                .resizable()
                .rotationEffect(.degrees(54 + selectedAngle))
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
                .scaleEffect(pressButton ? 0.9 : 1)
                
                .onLongPressGesture(minimumDuration: 0.01, pressing:
                                        {inProgress in
                                            print("In progress: \(inProgress)")
                                            pressButton.toggle()
                                            AudioServicesPlaySystemSound(1018)
                                        }) {
                    print("Long press")
                    pressButton = false
                    lastMoodRating = selectedValue + 1
                    scoreEntered += 1
                }
                
                .rotationEffect(currentAmount + finalAmount)
                .gesture(
                    RotationGesture()
                        .onChanged { angle in
                            self.currentAmount = angle
                        }
                        .onEnded { angle in
                            self.finalAmount += self.currentAmount
                            self.currentAmount = .degrees(0)
                            
                            self.selectedAngle += finalAmount.degrees - totAngle/2
                        }
                )
            
            
            ForEach(0..<anglePoints.count) {index in
                
                ZStack{
                    Circle()
                        .strokeBorder(Color.gray,lineWidth: 1)
                        .background(Circle().foregroundColor(index>selectedValue ? Color.gray : colorPoints).opacity(0.8))
                        .frame(width: 10, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .offset(x: -80, y: 0)
                        .rotationEffect(.degrees(anglePoints[index]))
                    
                    Text("\(index+1)")
                        .font(.system(size: 10))
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        .rotationEffect(.degrees(270))
                        .offset(x: -100, y: 0)
                        .rotationEffect(.degrees(anglePoints[index]))
                } // fin ZStack 2
                .onAppear{
                    selectedValue = initValue - 1
                    selectedAngle = anglePoints[initValue - 1] - 90
                }
                .onTapGesture {
                    selectedValue = index
                    selectedAngle = anglePoints[index] - 90
                    pressButton = false
                }
                
            } // fin ForEach
            
            //            VStack{
            //            Text("\(selectedAngle)")
            //            Text("\(finalAmount.degrees)")
            //            }
            
        } // fin ZStack 1
        .scaleEffect(CGSize(width: scale, height: scale))
        .animation(.easeOut)
        
        
    }
}

struct WheelButton_Previews: PreviewProvider {
    static var previews: some View {
        WheelButton(totAngle: 270, scale: 1.5, colorPoints: .orange, initValue: 1, scoreEntered: .constant(0))
    }
}

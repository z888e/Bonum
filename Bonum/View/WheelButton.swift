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
    
    @Binding var newClic: Bool
    
    @State var fromLeft: Bool = true
    
    var body: some View {
        
        ZStack{
            
            MrBonum(mood: selectedValue+1, moodFrom: fromLeft ? selectedValue-1+1 : selectedValue+1+1)
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .offset(x: 0, y: -180)
                .scaleEffect(CGSize(width: 0.8, height: 0.8))
                .padding(.bottom, 60)
            
            // La bague autour
            //pas fini
            //            Circle()
            //               .strokeBorder(
            //                    AngularGradient(gradient: Gradient(colors: [.red, .green, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)),
            //                    lineWidth: 8
            //                )
            //                .foregroundColor(Color("AppColor1"))
            ////                .strokeBorder(Color("AppColor1"),lineWidth: 1)
            //                .background(Circle().foregroundColor(Color("AppColor1")))
            //                .padding().frame(height: 200)
            //                .frame(width: 123, height: 123)
            //                .shadow(color: Color("AppColor1").opacity(0.8), radius: 3)
            
            //        Circle()
            //            .resizable()
            //            .rotationEffect(.degrees(54))
            //            .frame(width: 123, height: 123, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            //            .clipShape(Circle())
            //            .shadow(radius: 10)
            
            // Le bouton du milieu
            ZStack{
                Circle()
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [Color("AppColor3").opacity(0.6), Color("AppColor3").opacity(0.8), Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.8),
                            Color("AppColor3").opacity(0.3)]), center: .center, startAngle: .degrees(-110), endAngle: .degrees(250))
                    )
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
            .rotationEffect(.degrees(20 + selectedAngle))
            .frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .scaleEffect(pressButton ? 0.9 : 1)
            .onLongPressGesture(minimumDuration: 0.01, pressing:
                                    {inProgress in
                                        print("In progress: \(inProgress)")
                                        pressButton.toggle()
                                        AudioServicesPlaySystemSound(1001)
                                    }) {
                print("Long press")
                pressButton = false
                lastMoodRating = selectedValue + 1
                newClic.toggle()
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
                        .strokeBorder(Color("AppColor3"),lineWidth: 1)
                        .background(Circle().foregroundColor(index>selectedValue ? Color("AppColorWhite") : ratingColorMapping[index+1]).opacity(1.0))
                        .frame(width: 8, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .offset(x: -75, y: 0)
                        .rotationEffect(.degrees(anglePoints[index]))
                    
                    Text("\(index+1)")
                        .font(.system(size: 8))
                        .opacity(0.7)
                        .foregroundColor(Color("AppColor3"))
                        .rotationEffect(.degrees(270))
                        .offset(x: -90, y: 0)
                        .rotationEffect(.degrees(anglePoints[index]))
                } // fin ZStack 2
                .onAppear{
                    selectedValue = initValue - 1
                    selectedAngle = anglePoints[initValue - 1] - 90
                }
                .padding(10)
                .onTapGesture {
                    fromLeft = index > selectedValue
                    selectedValue = index
                    selectedAngle = anglePoints[index] - 90
                    pressButton = false
                }
                
            } // fin ForEach
            
        } // fin ZStack 1
        .scaleEffect(CGSize(width: scale, height: scale))
        .animation(Animation.easeIn)
    }
    
}

struct WheelButton_Previews: PreviewProvider {
    static var previews: some View {
        WheelButton(totAngle: 270, scale: 1.5, initValue: 2, newClic: .constant(false))
    }
}

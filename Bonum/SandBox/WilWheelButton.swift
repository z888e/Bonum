//
//  WilwheelButton.swift
//  Bonum
//
//  Created by Wilfried Roguet on 21/06/2021.
//

import SwiftUI

struct WilwheelButton: View {
    
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
    
    @State private var selectedValue: Int = 0
    @State private var selectedAngle: Double = 0
    
    var body: some View {
        ZStack{
            
            Image("moletteM")
                .resizable()
                .rotationEffect(.degrees(54))
                .frame(width: 123, height: 123, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            Image("moletteS")
                .resizable()
                .rotationEffect(.degrees(54 + selectedAngle))
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
            
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
                }
                .onAppear{
                    selectedValue = initValue - 1
                    selectedAngle = anglePoints[initValue - 1] - 90
                }
                .onTapGesture {
                    selectedValue = index
                    selectedAngle = anglePoints[index] - 90
                }
            } // fin ZStack 2
            
//            Circle()
//                .fill(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom))
            
        } // fin ZStack 1
        .scaleEffect(1.5)
        .animation(.easeOut)
        
    }
}

struct WilwheelButton_Previews: PreviewProvider {
    static var previews: some View {
        WilwheelButton(totAngle: 270, scale: 1.5, colorPoints: .orange, initValue: 1)
    }
}

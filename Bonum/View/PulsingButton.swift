//
//  PulsingButton.swift
//  Bonum
//
//  Created by Wilfried Roguet on 18/06/2021.
//

import SwiftUI

struct PulsingButton: View {
    
    let colorB: Color
    let sizeB: CGFloat
    let minimumRatioB: CGFloat
    var durationB: Double
    
    @State private var animate = false
    @State private var durationC: Double = 3
    @State private var tog: Bool = false
    
    var body: some View {
        VStack{
            
            ZStack{
                Circle().fill(colorB.opacity(0.25)).frame(width: sizeB, height: sizeB).scaleEffect(self.animate ? 0.85 : minimumRatioB)
                
                Circle().fill(colorB.opacity(0.35)).frame(width: sizeB*0.75, height: sizeB*0.70).scaleEffect(self.animate ? 1 : minimumRatioB)
                
                Circle().fill(colorB.opacity(0.45)).frame(width: sizeB*0.5, height: sizeB*0.5).scaleEffect(self.animate ? 1 : minimumRatioB)
                
                Circle().fill(Color.white).frame(width: sizeB*0.53, height: sizeB*0.53)
                
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: sizeB*0.5))
                    .foregroundColor(colorB)
                
            } // Fin ZStack
            .onAppear{
                self.animate.toggle()
            }
            .animation(Animation.linear(duration: durationB).repeatForever(autoreverses: true))
            
            //            Stepper("\(durationC)", value: $durationC)
            //            Toggle(isOn: $animate, label: {
            //                /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
            //            })
            
        } // Fin VStack
        
    }
}

struct PulsingButton_Previews: PreviewProvider {
    static var previews: some View {
        PulsingButton(colorB: .orange, sizeB: 100, minimumRatioB: 0.5, durationB: 0.8)
    }
}

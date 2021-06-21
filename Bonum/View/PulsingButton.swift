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
    let durationB: Double
    
    @State var animate = false
    
    var body: some View {
        
            ZStack{
                Circle().fill(colorB.opacity(0.25)).frame(width: sizeB, height: sizeB).scaleEffect(self.animate ? 1 : minimumRatioB)
                
                Circle().fill(colorB.opacity(0.35)).frame(width: sizeB*0.75, height: sizeB*0.75).scaleEffect(self.animate ? 1 : minimumRatioB)
                
                Circle().fill(colorB.opacity(0.45)).frame(width: sizeB*0.5, height: sizeB*0.5).scaleEffect(self.animate ? 1 : minimumRatioB)
                
                Circle().fill(Color.white).frame(width: sizeB*0.4, height: sizeB*0.4)
                
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: sizeB*0.5))
                    .foregroundColor(colorB)
                
                //            Circle().fill(colorB.opacity(1)).frame(width: sizeB*0.2, height: sizeB*0.2).scaleEffect(self.animate ? minimumRatioB : 1)
            }
            .onAppear{
                self.animate.toggle()
            }
            .animation(Animation.linear(duration: durationB).repeatForever(autoreverses: true))
        
    }
}

struct PulsingButton_Previews: PreviewProvider {
    static var previews: some View {
        PulsingButton(colorB: .orange, sizeB: 100, minimumRatioB: 0.5, durationB: 0.3)
    }
}

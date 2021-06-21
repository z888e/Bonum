//
//  WilAnimation.swift
//  Bonum
//
//  Created by Wilfried Roguet on 21/06/2021.
//

import SwiftUI

struct WilAnimation: View {
    
    @State private var animate: Bool = false
    @State private var icon = "😁"
    
    var body: some View {
        VStack{
            Text(icon)
                .font(.system(size: 56.0))
                .scaleEffect(self.animate ? 1 : 0.5)
                .rotationEffect(Angle(degrees: self.animate ? 100.0: 0))
                .offset(x: self.animate ? 100.0: 0, y: self.animate ? 200: 0)
                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: true))
                .onTapGesture {
                    self.icon = self.animate ? "🤓" : "😘"
                }
            
            Text("🤪")
                .font(.system(size: 56.0))
                .offset(x: self.animate ? 100.0: 0, y: self.animate ? 200: 0)
                .rotationEffect(Angle(degrees: self.animate ? 100.0: 0))
                .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))

            Spacer()
            
            Toggle(isOn: $animate) {
                Text("Animer")
            }
            .padding()
        }
        .onChange(of: animate, perform: { value in
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
        })
    }
}

struct WilAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WilAnimation()
    }
}

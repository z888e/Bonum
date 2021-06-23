//
//  ThomasTestMrBonumCorpus.swift
//  Bonum
//
//  Created by Thomas on 21/06/2021.
//

import SwiftUI

struct ThomasTestMrBonumCorpus: View {
    
    @State private var progress: CGFloat = 0
    
    // Les couleurs des 10 états de forme :
    let couleurMood: [[Double]] = [[0.00, 0.00, 0.00], [1.00, 0.1863677502, 0.05024763197], [1.00, 0.3130919337, 0.00], [0.9529370666, 0.4147374034, 0.00], [1.00, 0.5982946157, 0.00], [1.00, 0.8351451755, 0.00], [0.8309281468, 0.8181648254, 0.00], [0.682051599, 0.8307157159, 0.00 ], [0.4331716299, 0.7751298547, 0.00], [0.231847465, 0.7812655568, 0.109912999], [0.00, 0.7668917179, 0.2233996391]]
    
    var body: some View {
        
        ZStack {
            
        PathCorps(progress: progress, s1: [60, 99, 45, 99, 45, 91, 38, 99, 38, 91, 56, 91, 50, 78, 54, 68, 48, 73, 76, 64, 79, 76, 86, 68, 89, 96, 84, 98, 88, 101, 73, 77, 61, 79, 65, 93, 60, 99, 65, 99], s2: [51, 76, 48, 95, 39, 94, 46, 100, 40, 100, 42, 77, 36, 63, 35, 54, 32, 57, 56, 43, 61, 54, 68, 44, 53, 77, 47, 75, 50, 79, 53, 57, 45, 62, 49, 70, 51, 76, 50, 73])
            .fill(Color.black)
            .frame(width: 150)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever() ) {
                    progress = 1
                }
            }
            
            PathTete(progress: progress, s1: [90, 77], s2: [74, 50])
                .fill(progress == 1 ? Color(red: couleurMood[2][0], green: couleurMood[2][1], blue: couleurMood[2][2], opacity: 1.00) : Color(red: couleurMood[1][0], green: couleurMood[1][1], blue: couleurMood[1][2], opacity: 1.00))
                .frame(width: 150)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever() ) {
                        progress = 1
                    }
                }
            
        } // ZStack
        
    }
}

struct PathCorps: Shape {
    
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    var s1: [CGFloat]
    
    var s2: [CGFloat]
    
    var diffS: [CGFloat] {
        zip(s2, s1).map {$0.0 - $0.1}
    }
    
    var currentS: [CGFloat] {
        zip(s1, diffS).map{ $0.0 + $0.1 * progress}
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let e = min(Double(150.00), Double(150.00)) / 100.00 // On veut le dessiner dans un 150 x 150.
        
        let s: [Double] = currentS.map { Double($0) * e } // Changement d'échelle.
        
        // On part du genoux :
        path.move(to: CGPoint(x: s[0], y: s[1]))
        path.addLine(to: CGPoint(x: s[2], y: s[3]))
        
        // Le pied :
        path.addCurve(to: CGPoint(x: s[4], y: s[5]), control1: CGPoint(x: s[6], y: s[7]), control2: CGPoint(x: s[8], y: s[9]))
        
        path.addLine(to: CGPoint(x: s[10], y: s[11]))
        path.addLine(to: CGPoint(x: s[12], y: s[13]))
        path.addQuadCurve(to: CGPoint(x: s[14], y: s[15]), control: CGPoint(x: s[16], y: s[17]))
        path.addLine(to: CGPoint(x: s[18], y: s[19]))
        
        // Les épaules :
        path.addQuadCurve(to: CGPoint(x: s[20], y: s[21]), control: CGPoint(x: s[22], y: s[23]))
        path.addLine(to: CGPoint(x: s[24], y: s[25]))
        
        // La main :
        path.addQuadCurve(to: CGPoint(x: s[26], y: s[27]), control: CGPoint(x: s[28], y: s[29]))
        
        path.addLine(to: CGPoint(x: s[30], y: s[31]))
        path.addLine(to: CGPoint(x: s[32], y: s[33]))
        path.addLine(to: CGPoint(x: s[34], y: s[35]))
        
        // On revient au genoux :
        path.addQuadCurve(to: CGPoint(x: s[36], y: s[37]), control: CGPoint(x: s[38], y: s[39]))
        
        path.closeSubpath()
        
        return path
    }
    
}

struct PathTete: Shape {
    
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    var s1: [CGFloat]
    
    var s2: [CGFloat]

    var diffS: [CGFloat] {
        zip(s2, s1).map {$0.0 - $0.1}
    }
    
    var currentS: [CGFloat] {
        zip(s1, diffS).map{ $0.0 + $0.1 * progress}
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let e = min(Double(150.00), Double(150.00)) / 100.00 // On veut le dessiner dans un 150 x 150.
        
        let s: [Double] = currentS.map { Double($0) * e } // Changement d'échelle.
        
                          path.addArc(center: CGPoint(x: s[0], y: s[1]), radius: CGFloat(8.00 * e), startAngle: .degrees(0), endAngle: .degrees(1), clockwise: true)
                           path.closeSubpath()
        
        return path
    }
    
}

struct ThomasTestMrBonumCorpus_Previews: PreviewProvider {
    static var previews: some View {
        ThomasTestMrBonumCorpus()
    }
}

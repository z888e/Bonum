//
//  MrBonum.swift
//  Bonum
//
//  Created by Thomas on 19/06/2021.
//

import SwiftUI

struct MrBonum: View { // De 1 à 10.
    var mood: Int {
        willSet{
            progress = 0
        }
    }
    
    var moodFrom: Int // De 1 à 10. Attention : toujours 1 d'écart entre mood et moodFrom.
    
    // Les 10 dessins de MrBonum (en fait pour l'instant 5 dessins différents et 2 étapes avec le même) :
    let s1: [CGFloat] = [60, 99, 45, 99, 45, 91, 38, 99, 38, 91, 56, 91, 50, 78, 54, 68, 48, 73, 76, 64, 79, 76, 86, 68, 89, 96, 84, 98, 88, 101, 73, 77, 61, 79, 61, 79, 61, 79, 61, 79, 61, 79, 61, 79, 61, 79, 61, 79, 65, 93, 60, 99, 65, 99, 90, 77]
    let s2: [CGFloat] = [60, 99, 45, 99, 45, 91, 38, 99, 38, 91, 56, 91, 50, 78, 54, 68, 48, 73, 76, 64, 79, 76, 86, 68, 89, 96, 84, 98, 88, 101, 73, 77, 61, 79, 61, 79, 61, 79, 61, 79, 61, 79, 61, 79, 61, 79, 61, 79, 65, 93, 60, 99, 65, 99, 90, 77]
    let s3: [CGFloat] = [51, 76, 48, 95, 39, 94, 46, 100, 40, 100, 42, 77, 36, 63, 35, 54, 32, 57, 56, 43, 61, 54, 68, 44, 53, 77, 47, 75, 50, 79, 53, 57, 45, 62, 45, 62, 45, 62, 45, 62, 45, 62, 45, 62, 45, 62, 45, 62, 49, 70, 51, 76, 50, 73, 74, 50]
    let s4: [CGFloat] = [51, 76, 48, 95, 39, 94, 46, 100, 40, 100, 42, 77, 36, 63, 35, 54, 32, 57, 56, 43, 61, 54, 68, 44, 53, 77, 47, 75, 50, 79, 53, 57, 45, 62, 45, 62, 45, 62, 45, 62, 45, 62, 45, 62, 45, 62, 45, 62, 49, 70, 51, 76, 50, 73, 74, 50]
    let s5: [CGFloat] = [58, 82, 48, 95, 39, 94, 46, 100, 40, 100, 50, 79, 49, 66, 46, 58, 46, 64, 51, 36, 61, 45, 62, 31, 71, 60, 68, 64, 72, 63, 59, 52, 58, 64, 68, 73, 69, 75, 69, 74, 73, 96, 65, 96, 69, 100, 62, 79, 58, 75, 58, 82, 60, 78, 63, 26]
    let s6: [CGFloat] = [58, 82, 48, 95, 39, 94, 46, 100, 40, 100, 50, 79, 49, 66, 46, 58, 46, 64, 51, 36, 61, 45, 62, 31, 71, 60, 68, 64, 72, 63, 59, 52, 58, 64, 68, 73, 69, 75, 69, 74, 73, 96, 65, 96, 69, 100, 62, 79, 58, 75, 58, 82, 60, 78, 63, 26]
    let s7: [CGFloat] = [58, 82, 48, 95, 39, 94, 46, 100, 40, 100, 50, 79, 49, 66, 46, 58, 46, 64, 51, 36, 61, 45, 62, 31, 71, 60, 68, 64, 72, 63, 59, 52, 58, 64, 68, 73, 69, 75, 69, 74, 73, 96, 65, 96, 69, 100, 62, 79, 58, 75, 58, 82, 60, 78, 63, 26]
    let s8: [CGFloat] = [58, 82, 48, 95, 39, 94, 46, 100, 40, 100, 50, 79, 49, 66, 46, 58, 46, 64, 51, 36, 61, 45, 62, 31, 71, 60, 68, 64, 72, 63, 59, 52, 58, 64, 68, 73, 69, 75, 69, 74, 73, 96, 65, 96, 69, 100, 62, 79, 58, 75, 58, 82, 60, 78, 63, 26]
    let s9: [CGFloat] = [58, 82, 48, 95, 39, 94, 46, 100, 40, 100, 50, 79, 49, 66, 46, 58, 46, 64, 51, 36, 61, 45, 62, 31, 71, 60, 68, 64, 72, 63, 59, 52, 58, 64, 68, 73, 69, 75, 69, 74, 73, 96, 65, 96, 69, 100, 62, 79, 58, 75, 58, 82, 60, 78, 63, 26]
    let s10: [CGFloat] = [58, 82, 48, 95, 39, 94, 46, 100, 40, 100, 50, 79, 49, 66, 46, 58, 46, 64, 51, 36, 61, 45, 62, 31, 71, 60, 68, 64, 72, 63, 59, 52, 58, 64, 68, 73, 69, 75, 69, 74, 73, 96, 65, 96, 69, 100, 62, 79, 58, 75, 58, 82, 60, 78, 63, 26]
    
    // Les couleurs des 10 états de forme (un tableau vide en [0] pour éviter les "mood - 1") :
    let couleurMood: [[Double]] = [[0.00, 0.00, 0.00], [1.00, 0.1863677502, 0.05024763197], [1.00, 0.3130919337, 0.00], [0.9529370666, 0.4147374034, 0.00], [1.00, 0.5982946157, 0.00], [1.00, 0.8351451755, 0.00], [0.8309281468, 0.8181648254, 0.00], [0.682051599, 0.8307157159, 0.00 ], [0.4331716299, 0.7751298547, 0.00], [0.231847465, 0.7812655568, 0.109912999], [0.00, 0.7668917179, 0.2233996391]]
    
    @State private var progress: CGFloat = 0
    
    var sFrom: [CGFloat] {
        switch moodFrom {
        case 1:
            return s1
        case 2:
            return s2
        case 3:
            return s3
        case 4:
            return s4
        case 5:
            return s5
        case 6:
            return s6
        case 7:
            return s7
        case 8:
            return s8
        case 9:
            return s9
        case 10:
            return s10
        default:
            return s1
        }
    }
    
    var sTo: [CGFloat] {
        switch mood {
        case 1:
            return s1
        case 2:
            return s2
        case 3:
            return s3
        case 4:
            return s4
        case 5:
            return s5
        case 6:
            return s6
        case 7:
            return s7
        case 8:
            return s8
        case 9:
            return s9
        case 10:
            return s10
        default:
            return s1
        }
    }
    
    var couleurTeteFrom: Color {
        Color(red: couleurMood[moodFrom][0], green: couleurMood[moodFrom][1], blue: couleurMood[moodFrom][2], opacity: 1.00)
    }
    
    var couleurTeteTo: Color {
        Color(red: couleurMood[mood][0], green: couleurMood[mood][1], blue: couleurMood[mood][2], opacity: 1.00)
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                
                PathCorps(progress: progress, sf: sFrom, st: sTo)
                    .fill(progress == 1 ? couleurTeteTo : couleurTeteFrom)

                PathTete(progress: progress, sf: sFrom, st: sTo)
                    .fill(progress == 1 ? couleurTeteTo : couleurTeteFrom)
                
            } // ZStack
            .frame(width: 150)
        } // VStack.
        .onChange(of: mood, perform: { value in
            progress = 0
            withAnimation(.easeInOut(duration: 1) ) {
                progress = 1
            }
        })
    }
}

struct PathCorps: Shape {
    
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    var sf, st: [CGFloat]
    
    var diffS: [CGFloat] {
        zip(st, sf).map {$0.0 - $0.1}
    }
    
    var currentS: [CGFloat] {
        zip(sf, diffS).map{ $0.0 + $0.1 * progress}
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let e = min(Double(150.00), Double(150.00)) / 100.00 // On veut le dessiner dans un 150 x 150 (et les points sont dans un 100 x 100).
        
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
        
        // Le haut du bras :
        path.addLine(to: CGPoint(x: s[24], y: s[25]))
        
        // La main :
        path.addQuadCurve(to: CGPoint(x: s[26], y: s[27]), control: CGPoint(x: s[28], y: s[29]))
        
        // Le dessous du bras :
        path.addLine(to: CGPoint(x: s[30], y: s[31]))
        
        // Le ventre :
        path.addLine(to: CGPoint(x: s[32], y: s[33]))
        
        // Jambe 1 :
        
        // Dessus de la cuisse :
        path.addLine(to: CGPoint(x: s[34], y: s[35]))

        // Le genoux :
        path.addQuadCurve(to: CGPoint(x: s[36], y: s[37]), control: CGPoint(x: s[38], y: s[39]))
        
        // Dessus de la jambe :
        path.addLine(to: CGPoint(x: s[40], y: s[41]))
        
        // Le pied :
        path.addQuadCurve(to: CGPoint(x: s[42], y: s[43]), control: CGPoint(x: s[44], y: s[45]))

        // Dessous de la jambe :
        path.addLine(to: CGPoint(x: s[46], y: s[47]))
        
        // Jambe 2 :
        
        // Dessus de la cuisse :
        path.addLine(to: CGPoint(x: s[48], y: s[49]))
        
        // On revient au genoux :
        path.addQuadCurve(to: CGPoint(x: s[50], y: s[51]), control: CGPoint(x: s[52], y: s[53]))
        
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
    
    var sf, st: [CGFloat]
    
    var diffS: [CGFloat] {
        zip(st, sf).map {$0.0 - $0.1}
    }
    
    var currentS: [CGFloat] {
        zip(sf, diffS).map{ $0.0 + $0.1 * progress}
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let e = min(Double(150.00), Double(150.00)) / 100.00 // On veut le dessiner dans un 150 x 150.
        
        let s: [Double] = currentS.map { Double($0) * e } // Changement d'échelle.
        
        path.addArc(center: CGPoint(x: s[54], y: s[55]), radius: CGFloat(8.00 * e), startAngle: .degrees(0), endAngle: .degrees(1), clockwise: true)
        path.closeSubpath()
        
        return path
    }
    
}

struct MrBonum_Previews: PreviewProvider {
    static var previews: some View {
        MrBonum(mood: 3, moodFrom: 2)
    }
}

//
//  ThomasTestMrBonum.swift
//  Bonum
//
//  Created by Thomas on 18/06/2021.
//

import SwiftUI

struct DrawMrBonum: View {
    
    // Mr Bonum est dessiné dans un carré de 100 x 100 automatiquement mis à léchelle (mais pas déformé : toujours un carré) pour occuper tout l'espace.
    
    var mood: Int
    
    //    @State private var x: [[Double]] = [[80, 80],[80, 80]]
    //
    //    @State private var y: [[Double]] = [[80, 30],[80, 80]]
    
    @State private var s1: [Double] = [60, 99, 45, 99, 45, 91, 38, 99, 38, 91, 56, 91, 50, 78, 54, 68, 48, 73, 76, 64, 79, 76, 86, 68, 89, 96, 84, 98, 88, 101, 73, 77, 61, 79, 65, 93, 60, 99, 65, 99, 90, 77]
    
    @State private var s2: [Double] = [51, 76, 48, 95, 39, 94, 46, 100, 40, 100, 42, 77, 36, 63, 35, 54, 32, 57, 56, 43, 61, 54, 68, 44, 53, 77, 47, 75, 50, 79, 53, 57, 45, 62, 49, 70, 51, 76, 50, 73, 74, 50]
    
    var body: some View {
        
        GeometryReader { geo in // Pour récupérer les dimension de la zone dans laquelle on dessine.

//            let e = min(Double(geo.size.width), Double(geo.size.height)) / 100.00
            
//            let se1 = s1.map { $0 * e }
//
//            let se2 = s2.map { $0 * e }
//
//            ZStack {
//                // Le corps :
//                Path { path in
//                    path.move(to: CGPoint(x: s1[0]+d1[0]*progress, y: s1[1]+d1[1]*progress))
//                    path.addLine(to: CGPoint(x: s1[2]+d1[2]*progress, y: s1[3]+d1[3]*progress))
//
//                    // Le pied :
//                    path.addCurve(to: CGPoint(x: s1[4]+d1[4]*progress, y: s1[5]+d1[5]*progress), control1: CGPoint(x: s1[6]+d1[6]*progress, y: s1[7]+d1[7]*progress), control2: CGPoint(x: s1[8]+d1[8]*progress, y: s1[9]+d1[9]*progress))
//
//                    path.addLine(to: CGPoint(x: s1[10]+d1[10]*progress, y: s1[11]+d1[11]))
//                    path.addLine(to: CGPoint(x: s1[12]+d1[12], y: s1[13]+d1[13]))
//                    path.addQuadCurve(to: CGPoint(x: s1[14]+d1[14], y: s1[15]+d1[15]), control: CGPoint(x: s1[16]+d1[16], y: s1[17]+d1[17]))
//                    path.addLine(to: CGPoint(x: s1[18]+d1[18], y: s1[19]+d1[19]))
//
//                    // Les épaules :
//                    path.addQuadCurve(to: CGPoint(x: s1[20]+d1[20], y: s1[21]+d1[21]), control: CGPoint(x: s1[22]+d1[22], y: s1[23]+d1[23]))
//                    path.addLine(to: CGPoint(x: s1[24]+d1[24], y: s1[25]+d1[25]))
//
//                    // La main :
//                    path.addQuadCurve(to: CGPoint(x: s1[26]+d1[26], y: s1[27]+d1[27]), control: CGPoint(x: s1[28]+d1[28], y: s1[29]+d1[29]))
//
//                    path.addLine(to: CGPoint(x: s1[30]+d1[30], y: s1[31]+d1[31]))
//                    path.addLine(to: CGPoint(x: s1[32]+d1[32], y: s1[33]+d1[33]))
//                    path.addLine(to: CGPoint(x: s1[34]+d1[34], y: s1[35]+d1[35]))
//
//                    // Le genoux :
//                    path.addQuadCurve(to: CGPoint(x: s1[36]+d1[36], y: s1[37]+d1[37]), control: CGPoint(x: s1[38]+d1[38], y: s1[39]+d1[39]))
//
//                    path.closeSubpath()
//
//                } // Path
//                .fill(Color.black)
////                .animation(.linear(duration: 2.0))
//
//                // La tête :
//                Path { path in
//                    path.addArc(center: CGPoint(x: s1[40]+d1[40], y: s1[41]+d1[41]), radius: CGFloat(8.00 * e), startAngle: .degrees(0), endAngle: .degrees(1), clockwise: true)
//                    path.closeSubpath()
//
//                } // Path
//                .fill(Color.red)
//
//            } // ZStack
            
            
        } // GeometryReader
    }
}

struct ThomasTestMrBonum: View {
    
    @State private var mood: Double = 1.0
    
    var body: some View {
        VStack {
            
            Text("Niveau de forme : \(mood.description)")
            
            DrawMrBonum(mood: Int(mood))
                
            
            
            Slider(value: $mood, in: 1...10, step: 1).padding()
            
        }
    }
}

struct MrBonum1: View {
    
    var body: some View {
        VStack {
            
            ZStack {
                
                Rectangle()
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 100, height: 100)
                
                // Le corps :
                Path { path in
                    path.move(to: CGPoint(x: 60, y: 99))
                    path.addLine(to: CGPoint(x: 45, y: 99))
                    
                    // Le pied :
                    path.addCurve(to: CGPoint(x: 45, y: 91), control1: CGPoint(x: 38, y: 99), control2: CGPoint(x: 38, y: 91))
                    
                    path.addLine(to: CGPoint(x: 56, y: 91))
                    path.addLine(to: CGPoint(x: 50, y: 78))
                    path.addQuadCurve(to: CGPoint(x: 54, y: 68), control: CGPoint(x: 48, y: 73))
                    path.addLine(to: CGPoint(x: 76, y: 64))
                    
                    // Les épaules :
                    path.addQuadCurve(to: CGPoint(x: 79, y: 76), control: CGPoint(x: 86, y: 68))
                    path.addLine(to: CGPoint(x: 89, y: 96))
                    
                    // La main :
                    path.addQuadCurve(to: CGPoint(x: 84, y: 98), control: CGPoint(x: 88, y: 101))
                    
                    path.addLine(to: CGPoint(x: 73, y: 77))
                    path.addLine(to: CGPoint(x: 61, y: 79))
                    path.addLine(to: CGPoint(x: 65, y: 93))
                    
                    // Le genoux :
                    path.addQuadCurve(to: CGPoint(x: 60, y: 99), control: CGPoint(x: 65, y: 99))
                    
                    path.closeSubpath()
                    
                } // Path
                .fill(Color.gray)
                
                // La tête :
                Path { path in
                    path.addArc(center: CGPoint(x: 90, y: 77), radius: 8, startAngle: .degrees(0), endAngle: .degrees(1), clockwise: true)
                    path.closeSubpath()
                    
                } // Path
                .fill(Color.red)
                
            } // ZStack
            .frame(width: 100, height: 100)
            Spacer()
        }
        
    }
}

struct MrBonum2: View {
    
    var body: some View {
        VStack {
            
            ZStack {
                
                // Le corps :
                Path { path in
                    path.move(to: CGPoint(x: 51, y: 76))
                    path.addLine(to: CGPoint(x: 48, y: 95))
                    
                    // Le pied :
                    path.addCurve(to: CGPoint(x: 39, y: 94), control1: CGPoint(x: 46, y: 100), control2: CGPoint(x: 40, y: 100))
                    
                    path.addLine(to: CGPoint(x: 42, y: 77))
                    path.addLine(to: CGPoint(x: 36, y: 63))
                    path.addQuadCurve(to: CGPoint(x: 35, y: 54), control: CGPoint(x: 32, y: 57))
                    path.addLine(to: CGPoint(x: 56, y: 43))
                    
                    // Les épaules :
                    path.addQuadCurve(to: CGPoint(x: 61, y: 54), control: CGPoint(x: 68, y: 44))
                    
                    path.addLine(to: CGPoint(x: 53, y: 77))
                    
                    // La main :
                    path.addQuadCurve(to: CGPoint(x: 47, y: 75), control: CGPoint(x: 50, y: 79))
                    
                    path.addLine(to: CGPoint(x: 53, y: 57))
                    path.addLine(to: CGPoint(x: 45, y: 62))
                    path.addLine(to: CGPoint(x: 49, y: 70))
                    
                    // Le genoux :
                    path.addQuadCurve(to: CGPoint(x: 51, y: 76), control: CGPoint(x: 50, y: 73))
                    
                    path.closeSubpath()
                    
                } // Path
                .fill(Color.gray)
                //                .stroke(Color.green, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                
                // La tête :
                Path { path in
                    path.addArc(center: CGPoint(x: 74, y: 50), radius: 8, startAngle: .degrees(0), endAngle: .degrees(1), clockwise: true)
                    path.closeSubpath()
                    
                } // Path
                .fill(Color.green)
                
            } // ZStack
            .frame(width: 100, height: 100)
//            .background(
//                Image("TestBonum2") .resizable()
//                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
//                    .frame(width: 100, height: 100)
//            )
            Spacer()
        }
    }
}

struct MrBonum4: View {
    
    var body: some View {
        VStack {
            
            ZStack {
                
                // Le corps :
                Path { path in
                    path.move(to: CGPoint(x: 58, y: 82))
                    path.addLine(to: CGPoint(x: 48, y: 95))
                    
                    // Le pied :
                    path.addCurve(to: CGPoint(x: 39, y: 94), control1: CGPoint(x: 46, y: 100), control2: CGPoint(x: 40, y: 100))
                    
                    path.addLine(to: CGPoint(x: 50, y: 79))
                    path.addLine(to: CGPoint(x: 49, y: 66))
                    path.addQuadCurve(to: CGPoint(x: 46, y: 58), control: CGPoint(x: 46, y: 64))
                    path.addLine(to: CGPoint(x: 51, y: 36))
                    
                    // Les épaules :
                    path.addQuadCurve(to: CGPoint(x: 61, y: 41), control: CGPoint(x: 60, y: 31))
                    
                    path.addLine(to: CGPoint(x: 53, y: 77))
                    
                    // La main :
                    path.addQuadCurve(to: CGPoint(x: 47, y: 75), control: CGPoint(x: 50, y: 79))
                    
                    path.addLine(to: CGPoint(x: 53, y: 57))
                    path.addLine(to: CGPoint(x: 58, y: 62))
                    path.addLine(to: CGPoint(x: 58, y: 75))
                    
                    // Le genoux :
                    path.addQuadCurve(to: CGPoint(x: 58, y: 82), control: CGPoint(x: 60, y: 78))
                    
                    path.closeSubpath()
                    
                } // Path
//                .fill(Color.gray)
                                .stroke(Color.green, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                
                // La tête :
                Path { path in
                    path.addArc(center: CGPoint(x: 63, y: 26), radius: 8, startAngle: .degrees(0), endAngle: .degrees(1), clockwise: true)
                    path.closeSubpath()
                    
                } // Path
                .fill(Color.red)
                
            } // ZStack
            .frame(width: 100, height: 100)
            .background(
                Image("TestBonum4") .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            )
            Spacer()
        }
    }
}

struct ThomasTestMrBonum_Previews: PreviewProvider {
    static var previews: some View {
        
//        ThomasTestMrBonum()
        
                ZStack {
                    MrBonum4()
                    // MrBonum2()
                    // MrBonum1()
                }
        
//                DrawMrBonum(mood: 1)
    }
}

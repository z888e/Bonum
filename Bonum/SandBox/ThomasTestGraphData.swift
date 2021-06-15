//
//  ThomasTestGraphData.swift
//  Bonum
//
//  Created by Thomas on 15/06/2021.
//

import SwiftUI

var LARGEUR: Int = 300

var HAUTEUR: Int = 200

// 2% M1 :
//var VALUES: [Double] = [2138.51, 2526.87, 2733.66, 3057.20, 3218.17, 3434.23, 3441.94, 3515.55, 3557.33, 3678.64, 3593.85, 3593.78, 3467.33, 3463.27, 3307.22, 3174.90, 3065.94, 3069.42, 2855.10, 2782.14, 2675.48, 2441.14, 2360.05, 2254.11, 2065.46, 2008.72, 1876.66, 1754.50, 1676.55, 1558.76, 1545.44, 1421.98, 1398.83, 1332.02, 1319.32, 1306.37, 1320.30, 1308.44, 1350.63, 1407.83, 1451.20, 1569.11, 1625.23, 1691.83, 1823.13, 1990.23, 2091.84, 2291.22, 2388.04, 2591.06, 2809.37, 3042.77, 3290.96, 3519.07, 3646.05, 4002.60, 4214.77, 4384.53, 4596.83, 5007.22, 5281.22, 5558.64, 5665.10, 6180.49, 6211.64, 6550.86, 6756.28, 7097.09, 7291.06, 7629.30, 8046.91, 8057.02, 8298.58, 8531.55, 9022.90, 9333.61, 9355.74, 9452.47, 9920.74, 9691.74, 10237.65, 9964.03, 10279.97, 10477.50, 10343.37, 10711.36, 10533.37, 10437.70, 10424.51, 10597.59, 10430.95, 10447.42, 10231.12, 10192.68, 9726.83, 9634.02, 9604.38, 9258.78, 8799.86, 8671.00, 8499.82, 7965.75, 7417.26, 7213.17, 6551.40, 6074.77, 5625.98, 5137.52, 4471.88, 3920.43, 3361.92, 2616.07, 2022.77, 1257.55, 531.67, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2042.79, 5801.09, 9792.00]

// 30% M1 :
var VALUES: [Double] = [2138.51, 2651.96, 3235.77, 2330.74, 3507.81, 3501.57, 3233.34, 4048.21, 3198.01, 4508.14, 2515.70, 3415.87, 4518.04, 2468.87, 3774.91, 2300.19, 2534.09, 2347.20, 3230.02, 3333.06, 2072.19, 2466.05, 2690.45, 1763.11, 2023.31, 2147.93, 1745.29, 2233.00, 1425.07, 1304.27, 1166.66, 1755.71, 993.17, 1060.18, 1319.32, 1662.65, 1650.38, 1081.46, 1159.63, 1224.81, 1143.37, 1369.13, 1332.69, 1968.05, 2025.70, 1576.42, 2408.79, 2200.47, 2193.10, 1884.40, 3455.53, 3193.40, 3936.24, 2794.56, 3977.51, 4512.74, 5341.49, 4605.97, 4080.86, 3718.23, 4810.62, 5338.50, 5954.13, 6604.64, 6591.95, 8535.97, 5997.92, 5376.58, 7663.05, 6242.15, 10277.74, 6988.23, 8213.90, 7225.70, 10273.59, 10523.19, 7858.82, 8497.68, 7878.24, 9395.06, 7828.79, 12000.00, 8737.97, 12000.00, 9089.63, 11656.48, 10428.04, 10648.56, 11266.90, 7449.79, 9596.47, 10861.18, 11458.86, 9082.59, 9131.31, 7006.56, 10174.94, 9073.61, 10685.55, 7543.77, 8749.82, 9558.90, 6584.71, 6070.49, 6083.44, 5268.93, 6648.89, 3750.39, 5932.08, 3880.83, 4293.94, 2002.10, 2340.07, 1422.68, 685.85, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2226.64, 6199.21, 9024.00]

struct ThomasTestGraphData: View {
    
    var colors: [Color] = [.green, .green, .green, .green, .green]
    
    @State var currenColor: Color = .blue
        
    var body: some View {
        VStack {
            GrapheView(color: currenColor)
                .frame(width: CGFloat(LARGEUR), height: CGFloat(HAUTEUR), alignment: .center)
                .cornerRadius(5)

            Button(action: {
                var newColor = currenColor
                while currenColor == newColor {
                    newColor = colors.randomElement()!
                }
                currenColor = newColor
            }) {
                Text("Tracer le graph")
            }
            .padding(.top, 20)
        }
    }
}

struct GrapheView: View {
    @State private var prevColor: Color // only stores initial color, never changes
    var color: Color // only used to update layer (with onChange)
    @State private var layer: (color: Color, progress: CGFloat)? = nil // new color and progress

    // helpers : unwrap optionals
    var layerColor: Color {
        layer?.color ?? .clear
    }
    var layerProgress: CGFloat {
        layer?.progress ?? 0
    }
    
    init(color: Color) {
        _prevColor = State(initialValue: color)
        // en déclarant la prevColor en State sa valeur ne sera pas changée par la vue parente
        self.color = color
        // à l'inverse la color sera updatée si elle change "au dessus"
    }

    var body: some View {
        
                ZStack {
                    Rectangle()
                        .foregroundColor(self.prevColor)
                    Graphe(progress: layerProgress)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [layerColor, Color.blue]), startPoint: .top, endPoint: .bottom)
                        )
                    Graphe(closed: false, progress: layerProgress)
                        .stroke(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }

            .onChange(of: self.color) { color in
                // ceci est un tuple
                layer = (color: color, progress: 0)

                withAnimation(.linear(duration: 1.3)) {
                    // la variable que l'animation va progressivement faire bouger de 0 à 1 c'est celle-ci
                    layer?.progress = 1.0
                }
            }
    }
}

struct Graphe: Shape {

    var closed = true
    
    // Marges :
    var marginX: Double = 10.00
    var marginY: Double = 10.00

    // Taille :
    var width: Double = Double(LARGEUR)
    var height: Double = Double(HAUTEUR)

    var scaleX: Double {
        return (width - marginX) / Double(VALUES.count)
    }

    var scaleY: Double {
        guard let maxY = VALUES.max() else { return 1 }
        return (height - 2.00 * marginY) / (maxY - minY)
    }

    var minY: Double {
        return VALUES.min() ?? 0.0
    }

    var maxY: Double {
        return VALUES.max() ?? 0.0
    }

    // for animation
    var progress: CGFloat
    var animatableData: CGFloat {
        get { return progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        return leftToRight(rect: rect)
    }

    func getPosition(index: Int) -> CGPoint {
        guard !VALUES.isEmpty else { return .zero }
        if index <= 0 {
            return CGPoint(x: CGFloat(marginX), y: CGFloat((height - (VALUES[0] - minY) * scaleY) - marginY))
        }
        return CGPoint(x: CGFloat(marginX + Double(index) * scaleX), y: CGFloat((height - (VALUES[index] - minY) * scaleY) - marginY))
    }

    // for the last point
    // (sa position dépend de la progression de l'animation)
    func getPositionOfTheLastOne(nbOfCompleted: Int, percentOfTheLast: CGFloat) -> CGPoint {
        let indice = nbOfCompleted
        return CGPoint(x: getPosition(index: indice - 1).x + (getPosition(index: indice).x - getPosition(index: indice - 1).x) * percentOfTheLast, y: getPosition(index: indice - 1).y + (getPosition(index: indice).y - getPosition(index: indice - 1).y) * percentOfTheLast)
    }

    func leftToRight(rect: CGRect) -> Path {
        guard progress != 0 else { return Path() }
        let newProgress = progress * CGFloat(VALUES.count)
        var nbOfCompleted: Int = Int(newProgress)
        if nbOfCompleted == VALUES.count {
            nbOfCompleted -= 1
        }
        let percentOfTheLast = newProgress - CGFloat(nbOfCompleted)

        var path = Path()
        path.move(to: getPosition(index: 0))

        // tracer les segments complets
        VALUES.indices.filter({ $0 < nbOfCompleted }).forEach { indice in
            path.addLine(to: getPosition(index: indice))
        }

        // tracer le dernier segment (incomplet)
        path.addLine(to: getPositionOfTheLastOne(nbOfCompleted: nbOfCompleted, percentOfTheLast: percentOfTheLast))

        // fermer la forme
        if closed {
            path.addLine(to: CGPoint(x: getPositionOfTheLastOne(nbOfCompleted: nbOfCompleted, percentOfTheLast: percentOfTheLast).x, y: CGFloat(maxY)))

            path.addLine(to: CGPoint(x: CGFloat(marginX), y: CGFloat(110.00 - marginY)))

            path.closeSubpath()
        }
        return path
    }
}

struct ThomasTestGraphData_Previews: PreviewProvider {
    static var previews: some View {
        ThomasTestGraphData()
            .preferredColorScheme(.dark)
    }
}

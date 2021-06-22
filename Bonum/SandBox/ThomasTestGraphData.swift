////
////  ThomasTestGraphData.swift
////  Bonum
////
////  Created by Thomas on 15/06/2021.
////
//
//import SwiftUI
//
////TODO: intégrer à Journal Cell
//
//var LARGEUR: Int = 300
//
//var HAUTEUR: Int = 200
//
import SwiftUI

let DATAVALUES: [DataValue] = [DataValue(value: 2922.02, date: Date(timeIntervalSinceReferenceDate: 631152000)), DataValue(value: 3353.16, date: Date(timeIntervalSinceReferenceDate: 631238400)), DataValue(value: 3574.21, date: Date(timeIntervalSinceReferenceDate: 631324800)), DataValue(value: 4038.99, date: Date(timeIntervalSinceReferenceDate: 631411200)), DataValue(value: 3892.49, date: Date(timeIntervalSinceReferenceDate: 631497600)), DataValue(value: 3694.34, date: Date(timeIntervalSinceReferenceDate: 631584000)), DataValue(value: 4764.76, date: Date(timeIntervalSinceReferenceDate: 631670400)), DataValue(value: 4073.25, date: Date(timeIntervalSinceReferenceDate: 631756800)), DataValue(value: 4632.25, date: Date(timeIntervalSinceReferenceDate: 631843200)), DataValue(value: 3576.05, date: Date(timeIntervalSinceReferenceDate: 631929600)), DataValue(value: 3220.84, date: Date(timeIntervalSinceReferenceDate: 632016000)), DataValue(value: 3875.84, date: Date(timeIntervalSinceReferenceDate: 632102400)), DataValue(value: 4225.63, date: Date(timeIntervalSinceReferenceDate: 632188800)), DataValue(value: 4016.14, date: Date(timeIntervalSinceReferenceDate: 632275200)), DataValue(value: 3445.32, date: Date(timeIntervalSinceReferenceDate: 632361600)), DataValue(value: 4505.08, date: Date(timeIntervalSinceReferenceDate: 632448000)), DataValue(value: 3767.99, date: Date(timeIntervalSinceReferenceDate: 632534400)), DataValue(value: 2605.21, date: Date(timeIntervalSinceReferenceDate: 632620800)), DataValue(value: 3319.05, date: Date(timeIntervalSinceReferenceDate: 632707200)), DataValue(value: 3878.97, date: Date(timeIntervalSinceReferenceDate: 632793600)), DataValue(value: 2837.77, date: Date(timeIntervalSinceReferenceDate: 632880000)), DataValue(value: 3054.28, date: Date(timeIntervalSinceReferenceDate: 632966400)), DataValue(value: 2987.88, date: Date(timeIntervalSinceReferenceDate: 633052800)), DataValue(value: 3109.33, date: Date(timeIntervalSinceReferenceDate: 633139200)), DataValue(value: 2519.79, date: Date(timeIntervalSinceReferenceDate: 633225600)), DataValue(value: 2215.36, date: Date(timeIntervalSinceReferenceDate: 633312000)), DataValue(value: 2658.16, date: Date(timeIntervalSinceReferenceDate: 633398400)), DataValue(value: 2504.09, date: Date(timeIntervalSinceReferenceDate: 633484800)), DataValue(value: 1640.75, date: Date(timeIntervalSinceReferenceDate: 633571200)), DataValue(value: 1719.44, date: Date(timeIntervalSinceReferenceDate: 633657600)), DataValue(value: 2097.21, date: Date(timeIntervalSinceReferenceDate: 633744000)), DataValue(value: 1987.88, date: Date(timeIntervalSinceReferenceDate: 633830400)), DataValue(value: 1438.38, date: Date(timeIntervalSinceReferenceDate: 633916800)), DataValue(value: 1685.34, date: Date(timeIntervalSinceReferenceDate: 634003200)), DataValue(value: 1483.38, date: Date(timeIntervalSinceReferenceDate: 634089600)), DataValue(value: 1714.00, date: Date(timeIntervalSinceReferenceDate: 634176000)), DataValue(value: 1689.37, date: Date(timeIntervalSinceReferenceDate: 634262400)), DataValue(value: 1945.85, date: Date(timeIntervalSinceReferenceDate: 634348800)), DataValue(value: 2134.29, date: Date(timeIntervalSinceReferenceDate: 634435200)), DataValue(value: 2038.05, date: Date(timeIntervalSinceReferenceDate: 634521600)), DataValue(value: 2185.73, date: Date(timeIntervalSinceReferenceDate: 634608000)), DataValue(value: 2210.13, date: Date(timeIntervalSinceReferenceDate: 634694400)), DataValue(value: 2088.66, date: Date(timeIntervalSinceReferenceDate: 634780800)), DataValue(value: 1674.65, date: Date(timeIntervalSinceReferenceDate: 634867200)), DataValue(value: 2300.11, date: Date(timeIntervalSinceReferenceDate: 634953600)), DataValue(value: 2086.27, date: Date(timeIntervalSinceReferenceDate: 635040000)), DataValue(value: 3051.41, date: Date(timeIntervalSinceReferenceDate: 635126400)), DataValue(value: 2043.55, date: Date(timeIntervalSinceReferenceDate: 635212800)), DataValue(value: 3045.41, date: Date(timeIntervalSinceReferenceDate: 635299200)), DataValue(value: 2657.03, date: Date(timeIntervalSinceReferenceDate: 635385600)), DataValue(value: 3003.85, date: Date(timeIntervalSinceReferenceDate: 635472000)), DataValue(value: 3415.99, date: Date(timeIntervalSinceReferenceDate: 635558400)), DataValue(value: 2973.59, date: Date(timeIntervalSinceReferenceDate: 635644800)), DataValue(value: 3244.24, date: Date(timeIntervalSinceReferenceDate: 635731200)), DataValue(value: 3605.89, date: Date(timeIntervalSinceReferenceDate: 635817600)), DataValue(value: 5238.38, date: Date(timeIntervalSinceReferenceDate: 635904000)), DataValue(value: 5618.92, date: Date(timeIntervalSinceReferenceDate: 635990400)), DataValue(value: 5253.60, date: Date(timeIntervalSinceReferenceDate: 636076800)), DataValue(value: 5669.48, date: Date(timeIntervalSinceReferenceDate: 636163200)), DataValue(value: 5061.03, date: Date(timeIntervalSinceReferenceDate: 636249600)), DataValue(value: 5110.18, date: Date(timeIntervalSinceReferenceDate: 636336000)), DataValue(value: 6248.97, date: Date(timeIntervalSinceReferenceDate: 636422400)), DataValue(value: 7369.41, date: Date(timeIntervalSinceReferenceDate: 636508800)), DataValue(value: 4971.26, date: Date(timeIntervalSinceReferenceDate: 636595200)), DataValue(value: 6938.77, date: Date(timeIntervalSinceReferenceDate: 636681600)), DataValue(value: 7285.21, date: Date(timeIntervalSinceReferenceDate: 636768000)), DataValue(value: 6314.07, date: Date(timeIntervalSinceReferenceDate: 636854400)), DataValue(value: 6202.17, date: Date(timeIntervalSinceReferenceDate: 636940800)), DataValue(value: 8984.54, date: Date(timeIntervalSinceReferenceDate: 637027200)), DataValue(value: 6555.91, date: Date(timeIntervalSinceReferenceDate: 637113600)), DataValue(value: 8211.62, date: Date(timeIntervalSinceReferenceDate: 637200000)), DataValue(value: 6881.90, date: Date(timeIntervalSinceReferenceDate: 637286400)), DataValue(value: 7073.24, date: Date(timeIntervalSinceReferenceDate: 637372800)), DataValue(value: 10010.93, date: Date(timeIntervalSinceReferenceDate: 637459200)), DataValue(value: 11458.50, date: Date(timeIntervalSinceReferenceDate: 637545600)), DataValue(value: 10584.72, date: Date(timeIntervalSinceReferenceDate: 637632000)), DataValue(value: 12000.00, date: Date(timeIntervalSinceReferenceDate: 637718400)), DataValue(value: 11297.14, date: Date(timeIntervalSinceReferenceDate: 637804800)), DataValue(value: 8049.98, date: Date(timeIntervalSinceReferenceDate: 637891200)), DataValue(value: 7513.33, date: Date(timeIntervalSinceReferenceDate: 637977600)), DataValue(value: 7906.40, date: Date(timeIntervalSinceReferenceDate: 638064000)), DataValue(value: 9366.80, date: Date(timeIntervalSinceReferenceDate: 638150400)), DataValue(value: 10942.73, date: Date(timeIntervalSinceReferenceDate: 638236800)), DataValue(value: 12000.00, date: Date(timeIntervalSinceReferenceDate: 638323200)), DataValue(value: 12000.00, date: Date(timeIntervalSinceReferenceDate: 638409600)), DataValue(value: 8047.83, date: Date(timeIntervalSinceReferenceDate: 638496000)), DataValue(value: 12000.00, date: Date(timeIntervalSinceReferenceDate: 638582400)), DataValue(value: 10300.72, date: Date(timeIntervalSinceReferenceDate: 638668800)), DataValue(value: 12000.00, date: Date(timeIntervalSinceReferenceDate: 638755200)), DataValue(value: 10153.25, date: Date(timeIntervalSinceReferenceDate: 638841600)), DataValue(value: 12000.00, date: Date(timeIntervalSinceReferenceDate: 638928000)), DataValue(value: 11999.06, date: Date(timeIntervalSinceReferenceDate: 639014400)), DataValue(value: 9128.25, date: Date(timeIntervalSinceReferenceDate: 639100800)), DataValue(value: 12000.00, date: Date(timeIntervalSinceReferenceDate: 639187200)), DataValue(value: 10677.61, date: Date(timeIntervalSinceReferenceDate: 639273600)), DataValue(value: 8053.95, date: Date(timeIntervalSinceReferenceDate: 639360000)), DataValue(value: 10433.24, date: Date(timeIntervalSinceReferenceDate: 639446400)), DataValue(value: 9195.54, date: Date(timeIntervalSinceReferenceDate: 639532800)), DataValue(value: 10826.37, date: Date(timeIntervalSinceReferenceDate: 639619200)), DataValue(value: 6981.57, date: Date(timeIntervalSinceReferenceDate: 639705600)), DataValue(value: 9204.68, date: Date(timeIntervalSinceReferenceDate: 639792000)), DataValue(value: 9507.94, date: Date(timeIntervalSinceReferenceDate: 639878400)), DataValue(value: 9421.53, date: Date(timeIntervalSinceReferenceDate: 639964800)), DataValue(value: 9055.23, date: Date(timeIntervalSinceReferenceDate: 640051200)), DataValue(value: 5048.66, date: Date(timeIntervalSinceReferenceDate: 640137600)), DataValue(value: 6678.08, date: Date(timeIntervalSinceReferenceDate: 640224000)), DataValue(value: 6926.31, date: Date(timeIntervalSinceReferenceDate: 640310400)), DataValue(value: 6457.38, date: Date(timeIntervalSinceReferenceDate: 640396800)), DataValue(value: 5485.23, date: Date(timeIntervalSinceReferenceDate: 640483200)), DataValue(value: 4750.44, date: Date(timeIntervalSinceReferenceDate: 640569600)), DataValue(value: 3020.06, date: Date(timeIntervalSinceReferenceDate: 640656000)), DataValue(value: 2904.74, date: Date(timeIntervalSinceReferenceDate: 640742400)), DataValue(value: 2343.46, date: Date(timeIntervalSinceReferenceDate: 640828800)), DataValue(value: 1632.11, date: Date(timeIntervalSinceReferenceDate: 640915200)), DataValue(value: 1009.51, date: Date(timeIntervalSinceReferenceDate: 641001600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641088000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641174400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641260800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641347200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641433600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641520000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641606400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641692800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641779200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641865600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641952000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642038400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642124800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642211200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642297600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642384000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642470400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642556800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642643200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642729600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642816000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642902400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642988800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643075200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643161600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643248000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643334400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643420800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643507200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643593600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643680000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643766400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643852800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643939200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644025600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644112000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644198400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644284800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644371200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644457600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644544000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644630400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644716800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644803200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644889600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644976000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645062400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645148800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645235200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645321600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645408000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645494400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645580800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645667200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645753600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645840000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645926400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 646012800)), DataValue(value: 2966.67, date: Date(timeIntervalSinceReferenceDate: 646099200)), DataValue(value: 4860.30, date: Date(timeIntervalSinceReferenceDate: 646185600)), DataValue(value: 10528.00, date: Date(timeIntervalSinceReferenceDate: 646272000))]

//
//// 2% M1 :
////var VALUES: [Double] = [2138.51, 2526.87, 2733.66, 3057.20, 3218.17, 3434.23, 3441.94, 3515.55, 3557.33, 3678.64, 3593.85, 3593.78, 3467.33, 3463.27, 3307.22, 3174.90, 3065.94, 3069.42, 2855.10, 2782.14, 2675.48, 2441.14, 2360.05, 2254.11, 2065.46, 2008.72, 1876.66, 1754.50, 1676.55, 1558.76, 1545.44, 1421.98, 1398.83, 1332.02, 1319.32, 1306.37, 1320.30, 1308.44, 1350.63, 1407.83, 1451.20, 1569.11, 1625.23, 1691.83, 1823.13, 1990.23, 2091.84, 2291.22, 2388.04, 2591.06, 2809.37, 3042.77, 3290.96, 3519.07, 3646.05, 4002.60, 4214.77, 4384.53, 4596.83, 5007.22, 5281.22, 5558.64, 5665.10, 6180.49, 6211.64, 6550.86, 6756.28, 7097.09, 7291.06, 7629.30, 8046.91, 8057.02, 8298.58, 8531.55, 9022.90, 9333.61, 9355.74, 9452.47, 9920.74, 9691.74, 10237.65, 9964.03, 10279.97, 10477.50, 10343.37, 10711.36, 10533.37, 10437.70, 10424.51, 10597.59, 10430.95, 10447.42, 10231.12, 10192.68, 9726.83, 9634.02, 9604.38, 9258.78, 8799.86, 8671.00, 8499.82, 7965.75, 7417.26, 7213.17, 6551.40, 6074.77, 5625.98, 5137.52, 4471.88, 3920.43, 3361.92, 2616.07, 2022.77, 1257.55, 531.67, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2042.79, 5801.09, 9792.00]
//
//// 30% M1 :
//var VALUES: [Double] = [2138.51, 2651.96, 3235.77, 2330.74, 3507.81, 3501.57, 3233.34, 4048.21, 3198.01, 4508.14, 2515.70, 3415.87, 4518.04, 2468.87, 3774.91, 2300.19, 2534.09, 2347.20, 3230.02, 3333.06, 2072.19, 2466.05, 2690.45, 1763.11, 2023.31, 2147.93, 1745.29, 2233.00, 1425.07, 1304.27, 1166.66, 1755.71, 993.17, 1060.18, 1319.32, 1662.65, 1650.38, 1081.46, 1159.63, 1224.81, 1143.37, 1369.13, 1332.69, 1968.05, 2025.70, 1576.42, 2408.79, 2200.47, 2193.10, 1884.40, 3455.53, 3193.40, 3936.24, 2794.56, 3977.51, 4512.74, 5341.49, 4605.97, 4080.86, 3718.23, 4810.62, 5338.50, 5954.13, 6604.64, 6591.95, 8535.97, 5997.92, 5376.58, 7663.05, 6242.15, 10277.74, 6988.23, 8213.90, 7225.70, 10273.59, 10523.19, 7858.82, 8497.68, 7878.24, 9395.06, 7828.79, 12000.00, 8737.97, 12000.00, 9089.63, 11656.48, 10428.04, 10648.56, 11266.90, 7449.79, 9596.47, 10861.18, 11458.86, 9082.59, 9131.31, 7006.56, 10174.94, 9073.61, 10685.55, 7543.77, 8749.82, 9558.90, 6584.71, 6070.49, 6083.44, 5268.93, 6648.89, 3750.39, 5932.08, 3880.83, 4293.94, 2002.10, 2340.07, 1422.68, 685.85, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2226.64, 6199.21, 9024.00]


var VALUES: [Double] = [0, 0, 5000, 0, 0, 0, 0, 0, 0, 7654, 0, 2345, 3456, 0, 2345, 32768, 0, 0, 0, 0, 0, 0]

//var VALUES: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 2.500000000000007, 0, 0, 0, 0, 54, 0, 55, 61.999999999999993, 0, 65, 0, 0]

struct ThomasTestGraphData: View {
    
    var colors: [Color] = [.red, .blue, .green, .orange, .gray]
    
    @State var currenColor: Color = .blue
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Début de la période :")
//                Text(DATAVALUES[0].date, style: .date)
//            }
//            GrapheView(color: currenColor)
//                .frame(width: CGFloat(LARGEUR), height: CGFloat(HAUTEUR), alignment: .center)
//                .cornerRadius(5)
//            
//            Button(action: {
//                var newColor = currenColor
//                while currenColor == newColor {
//                    newColor = colors.randomElement()!
//                }
//                currenColor = newColor
//            }) {
//                Text("Tracer le graph")
//            }
//            .padding(.top, 20)
//        }
//    }
//}
//
//struct GrapheView: View {
//    @State private var prevColor: Color // only stores initial color, never changes
//    var color: Color // only used to update layer (with onChange)
//    @State private var layer: (color: Color, progress: CGFloat)? = nil // new color and progress
//    
//    // helpers : unwrap optionals
//    var layerColor: Color {
//        layer?.color ?? .clear
//    }
//    var layerProgress: CGFloat {
//        layer?.progress ?? 0
//    }
//    
//    init(color: Color) {
//        _prevColor = State(initialValue: color)
//        // en déclarant la prevColor en State sa valeur ne sera pas changée par la vue parente
//        self.color = color
//        // à l'inverse la color sera updatée si elle change "au dessus"
//    }
//    
//    var body: some View {
//        
//        ZStack {
//            Rectangle()
//                .foregroundColor(self.prevColor)
//            Graphe(progress: layerProgress)
//                .fill(
//                    LinearGradient(gradient: Gradient(colors: [layerColor, Color.blue]), startPoint: .top, endPoint: .bottom)
//                )
//            Graphe(closed: false, progress: layerProgress)
//                .stroke(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
//        }
//        
//        .onChange(of: self.color) { color in
//            // ceci est un tuple
//            layer = (color: color, progress: 0)
//            
//            withAnimation(.linear(duration: 1.3)) {
//                // la variable que l'animation va progressivement faire bouger de 0 à 1 c'est celle-ci
//                layer?.progress = 1.0
//            }
//        }
//    }
//}
//
//struct Graphe: Shape {
//    
//    var closed = true
//    
//    // Marges :
//    var marginX: Double = 10.00
//    var marginY: Double = 10.00
//    
//    // Taille :
//    var width: Double = Double(LARGEUR)
//    var height: Double = Double(HAUTEUR)
//    
//    var scaleX: Double {
//        return (width - marginX) / Double(VALUES.value)
//    }
//    
//    var scaleY: Double {
//        guard let maxY = VALUES.max() else { return 1 }
//        return (height - 2.00 * marginY) / (maxY - minY)
//    }
//    
//    var minY: Double {
//        return VALUES.min() ?? 0.0
//    }
//    
//    var maxY: Double {
//        return VALUES.max() ?? 0.0
//    }
//    
//    // for animation
//    var progress: CGFloat
//    var animatableData: CGFloat {
//        get { return progress }
//        set { progress = newValue }
//    }
//    
//    func path(in rect: CGRect) -> Path {
//        return leftToRight(rect: rect)
//    }
//    
//    func getPosition(index: Int) -> CGPoint {
//        guard !VALUES.isEmpty else { return .zero }
//        if index <= 0 {
//            return CGPoint(x: CGFloat(marginX), y: CGFloat((height - (VALUES[0] - minY) * scaleY) - marginY))
//        }
//        return CGPoint(x: CGFloat(marginX + Double(index) * scaleX), y: CGFloat((height - (VALUES[index] - minY) * scaleY) - marginY))
//    }
//    
//    // for the last point
//    // (sa position dépend de la progression de l'animation)
//    func getPositionOfTheLastOne(nbOfCompleted: Int, percentOfTheLast: CGFloat) -> CGPoint {
//        let indice = nbOfCompleted
//        return CGPoint(x: getPosition(index: indice - 1).x + (getPosition(index: indice).x - getPosition(index: indice - 1).x) * percentOfTheLast, y: getPosition(index: indice - 1).y + (getPosition(index: indice).y - getPosition(index: indice - 1).y) * percentOfTheLast)
//    }
//    
//    func leftToRight(rect: CGRect) -> Path {
//        guard progress != 0 else { return Path() }
//        let newProgress = progress * CGFloat(VALUES.value)
//        var nbOfCompleted: Int = Int(newProgress)
//        if nbOfCompleted == VALUES.value {
//            nbOfCompleted -= 1
//        }
//        let percentOfTheLast = newProgress - CGFloat(nbOfCompleted)
//        
//        var path = Path()
//        path.move(to: getPosition(index: 0))
//        
//        // tracer les segments complets
//        VALUES.indices.filter({ $0 < nbOfCompleted }).forEach { indice in
//            path.addLine(to: getPosition(index: indice))
//        }
//        
//        // tracer le dernier segment (incomplet)
//        path.addLine(to: getPositionOfTheLastOne(nbOfCompleted: nbOfCompleted, percentOfTheLast: percentOfTheLast))
//        
//        // fermer la forme
//        if closed {
//            path.addLine(to: CGPoint(x: getPositionOfTheLastOne(nbOfCompleted: nbOfCompleted, percentOfTheLast: percentOfTheLast).x, y: CGFloat(maxY)))
//
//struct ThomasTestGraphData_Previews: PreviewProvider {
//    static var previews: some View {
//        ThomasTestGraphData()
//            .preferredColorScheme(.dark)
//    }
//}

//
//  ThomasTestGraphData.swift
//  Bonum
//
//  Created by Thomas on 15/06/2021.
//

import SwiftUI

//var VALUES: [Double] = [2570.10, 2897.61, 3173.23, 3400.81, 3584.08, 3726.61, 3831.85, 3903.10, 3943.55, 3956.24, 3944.11, 3909.94, 3856.43, 3786.11, 3701.43, 3604.71, 3498.15, 3383.85, 3263.78, 3139.82, 3013.73, 2887.17, 2761.71, 2638.80, 2519.79, 2405.96, 2298.46, 2198.38, 2106.69, 2024.30, 1952.01, 1890.54, 1840.54, 1802.58, 1777.12, 1764.58, 1765.29, 1779.51, 1807.43, 1849.17, 1904.78, 1974.25, 2057.51, 2154.43, 2264.81, 2388.41, 2524.93, 2674.01, 2835.24, 3008.18, 3192.32, 3387.12, 3591.99, 3806.32, 4029.42, 4260.62, 4499.16, 4744.29, 4995.20, 5251.08, 5511.06, 5774.29, 6039.85, 6306.84, 6574.31, 6841.32, 7106.90, 7370.08, 7629.86, 7885.26, 8135.27, 8378.89, 8615.11, 8842.92, 9061.33, 9269.32, 9465.92, 9650.12, 9820.96, 9977.47, 10118.71, 10243.73, 10351.64, 10441.52, 10512.52, 10563.78, 10594.48, 10603.83, 10591.07, 10555.47, 10496.32, 10412.98, 10304.83, 10171.27, 10011.78, 9825.86, 9613.07, 9373.00, 9105.31, 8809.70, 8485.94, 8133.84, 7753.28, 7344.18, 6906.56, 6440.46, 5946.03, 5423.45, 4873.01, 4295.03, 3689.94, 3058.23, 2400.48, 1717.33, 1009.51, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 2457.68, 5950.37, 9700.00]

// M1 30%
var VALUES: [Double] = [2528.70, 2442.06, 2291.06, 3226.76, 4632.67, 3210.35, 2599.06, 5196.27, 3220.40, 3645.18, 4529.61, 2852.86, 4594.84, 5001.97, 3317.26, 3666.81, 4547.51, 2807.08, 3512.52, 3826.17, 2058.51, 3698.81, 1857.03, 2895.45, 3246.92, 3149.28, 1794.89, 2351.24, 2315.57, 1429.82, 2039.13, 1556.81, 1827.14, 2010.99, 1840.97, 1789.87, 1651.41, 1625.97, 1833.58, 2240.42, 1708.11, 2136.42, 1823.88, 1575.38, 1753.02, 2199.57, 1795.96, 3174.03, 3395.70, 2280.81, 4107.70, 2434.37, 2386.12, 3641.00, 3958.84, 4110.19, 5578.93, 3725.66, 3242.07, 4015.80, 4158.08, 6090.74, 5485.86, 4100.24, 7546.20, 5065.75, 4926.62, 10049.41, 9127.13, 6925.18, 6760.92, 5936.43, 7884.75, 11846.38, 7006.61, 6463.14, 11169.44, 8826.61, 10380.22, 11114.77, 12000.00, 12000.00, 12000.00, 7558.48, 12000.00, 10765.05, 10493.54, 7875.80, 12000.00, 7538.83, 9996.51, 9322.56, 8638.01, 7269.89, 11058.08, 11597.77, 11709.07, 11768.71, 6265.56, 10471.65, 10162.99, 9126.24, 6520.22, 8165.48, 7803.47, 5311.77, 7525.38, 6998.96, 3604.84, 2814.97, 3658.04, 2597.75, 2419.48, 1352.13, 984.04, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 500.00, 3162.44, 8076.02, 7952.00]

let DATAVALUES: [DataValue] = [DataValue(value: 2570.10, date: Date(timeIntervalSinceReferenceDate: 631152000)), DataValue(value: 2897.61, date: Date(timeIntervalSinceReferenceDate: 631238400)), DataValue(value: 3173.23, date: Date(timeIntervalSinceReferenceDate: 631324800)), DataValue(value: 3400.81, date: Date(timeIntervalSinceReferenceDate: 631411200)), DataValue(value: 3584.08, date: Date(timeIntervalSinceReferenceDate: 631497600)), DataValue(value: 3726.61, date: Date(timeIntervalSinceReferenceDate: 631584000)), DataValue(value: 3831.85, date: Date(timeIntervalSinceReferenceDate: 631670400)), DataValue(value: 3903.10, date: Date(timeIntervalSinceReferenceDate: 631756800)), DataValue(value: 3943.55, date: Date(timeIntervalSinceReferenceDate: 631843200)), DataValue(value: 3956.24, date: Date(timeIntervalSinceReferenceDate: 631929600)), DataValue(value: 3944.11, date: Date(timeIntervalSinceReferenceDate: 632016000)), DataValue(value: 3909.94, date: Date(timeIntervalSinceReferenceDate: 632102400)), DataValue(value: 3856.43, date: Date(timeIntervalSinceReferenceDate: 632188800)), DataValue(value: 3786.11, date: Date(timeIntervalSinceReferenceDate: 632275200)), DataValue(value: 3701.43, date: Date(timeIntervalSinceReferenceDate: 632361600)), DataValue(value: 3604.71, date: Date(timeIntervalSinceReferenceDate: 632448000)), DataValue(value: 3498.15, date: Date(timeIntervalSinceReferenceDate: 632534400)), DataValue(value: 3383.85, date: Date(timeIntervalSinceReferenceDate: 632620800)), DataValue(value: 3263.78, date: Date(timeIntervalSinceReferenceDate: 632707200)), DataValue(value: 3139.82, date: Date(timeIntervalSinceReferenceDate: 632793600)), DataValue(value: 3013.73, date: Date(timeIntervalSinceReferenceDate: 632880000)), DataValue(value: 2887.17, date: Date(timeIntervalSinceReferenceDate: 632966400)), DataValue(value: 2761.71, date: Date(timeIntervalSinceReferenceDate: 633052800)), DataValue(value: 2638.80, date: Date(timeIntervalSinceReferenceDate: 633139200)), DataValue(value: 2519.79, date: Date(timeIntervalSinceReferenceDate: 633225600)), DataValue(value: 2405.96, date: Date(timeIntervalSinceReferenceDate: 633312000)), DataValue(value: 2298.46, date: Date(timeIntervalSinceReferenceDate: 633398400)), DataValue(value: 2198.38, date: Date(timeIntervalSinceReferenceDate: 633484800)), DataValue(value: 2106.69, date: Date(timeIntervalSinceReferenceDate: 633571200)), DataValue(value: 2024.30, date: Date(timeIntervalSinceReferenceDate: 633657600)), DataValue(value: 1952.01, date: Date(timeIntervalSinceReferenceDate: 633744000)), DataValue(value: 1890.54, date: Date(timeIntervalSinceReferenceDate: 633830400)), DataValue(value: 1840.54, date: Date(timeIntervalSinceReferenceDate: 633916800)), DataValue(value: 1802.58, date: Date(timeIntervalSinceReferenceDate: 634003200)), DataValue(value: 1777.12, date: Date(timeIntervalSinceReferenceDate: 634089600)), DataValue(value: 1764.58, date: Date(timeIntervalSinceReferenceDate: 634176000)), DataValue(value: 1765.29, date: Date(timeIntervalSinceReferenceDate: 634262400)), DataValue(value: 1779.51, date: Date(timeIntervalSinceReferenceDate: 634348800)), DataValue(value: 1807.43, date: Date(timeIntervalSinceReferenceDate: 634435200)), DataValue(value: 1849.17, date: Date(timeIntervalSinceReferenceDate: 634521600)), DataValue(value: 1904.78, date: Date(timeIntervalSinceReferenceDate: 634608000)), DataValue(value: 1974.25, date: Date(timeIntervalSinceReferenceDate: 634694400)), DataValue(value: 2057.51, date: Date(timeIntervalSinceReferenceDate: 634780800)), DataValue(value: 2154.43, date: Date(timeIntervalSinceReferenceDate: 634867200)), DataValue(value: 2264.81, date: Date(timeIntervalSinceReferenceDate: 634953600)), DataValue(value: 2388.41, date: Date(timeIntervalSinceReferenceDate: 635040000)), DataValue(value: 2524.93, date: Date(timeIntervalSinceReferenceDate: 635126400)), DataValue(value: 2674.01, date: Date(timeIntervalSinceReferenceDate: 635212800)), DataValue(value: 2835.24, date: Date(timeIntervalSinceReferenceDate: 635299200)), DataValue(value: 3008.18, date: Date(timeIntervalSinceReferenceDate: 635385600)), DataValue(value: 3192.32, date: Date(timeIntervalSinceReferenceDate: 635472000)), DataValue(value: 3387.12, date: Date(timeIntervalSinceReferenceDate: 635558400)), DataValue(value: 3591.99, date: Date(timeIntervalSinceReferenceDate: 635644800)), DataValue(value: 3806.32, date: Date(timeIntervalSinceReferenceDate: 635731200)), DataValue(value: 4029.42, date: Date(timeIntervalSinceReferenceDate: 635817600)), DataValue(value: 4260.62, date: Date(timeIntervalSinceReferenceDate: 635904000)), DataValue(value: 4499.16, date: Date(timeIntervalSinceReferenceDate: 635990400)), DataValue(value: 4744.29, date: Date(timeIntervalSinceReferenceDate: 636076800)), DataValue(value: 4995.20, date: Date(timeIntervalSinceReferenceDate: 636163200)), DataValue(value: 5251.08, date: Date(timeIntervalSinceReferenceDate: 636249600)), DataValue(value: 5511.06, date: Date(timeIntervalSinceReferenceDate: 636336000)), DataValue(value: 5774.29, date: Date(timeIntervalSinceReferenceDate: 636422400)), DataValue(value: 6039.85, date: Date(timeIntervalSinceReferenceDate: 636508800)), DataValue(value: 6306.84, date: Date(timeIntervalSinceReferenceDate: 636595200)), DataValue(value: 6574.31, date: Date(timeIntervalSinceReferenceDate: 636681600)), DataValue(value: 6841.32, date: Date(timeIntervalSinceReferenceDate: 636768000)), DataValue(value: 7106.90, date: Date(timeIntervalSinceReferenceDate: 636854400)), DataValue(value: 7370.08, date: Date(timeIntervalSinceReferenceDate: 636940800)), DataValue(value: 7629.86, date: Date(timeIntervalSinceReferenceDate: 637027200)), DataValue(value: 7885.26, date: Date(timeIntervalSinceReferenceDate: 637113600)), DataValue(value: 8135.27, date: Date(timeIntervalSinceReferenceDate: 637200000)), DataValue(value: 8378.89, date: Date(timeIntervalSinceReferenceDate: 637286400)), DataValue(value: 8615.11, date: Date(timeIntervalSinceReferenceDate: 637372800)), DataValue(value: 8842.92, date: Date(timeIntervalSinceReferenceDate: 637459200)), DataValue(value: 9061.33, date: Date(timeIntervalSinceReferenceDate: 637545600)), DataValue(value: 9269.32, date: Date(timeIntervalSinceReferenceDate: 637632000)), DataValue(value: 9465.92, date: Date(timeIntervalSinceReferenceDate: 637718400)), DataValue(value: 9650.12, date: Date(timeIntervalSinceReferenceDate: 637804800)), DataValue(value: 9820.96, date: Date(timeIntervalSinceReferenceDate: 637891200)), DataValue(value: 9977.47, date: Date(timeIntervalSinceReferenceDate: 637977600)), DataValue(value: 10118.71, date: Date(timeIntervalSinceReferenceDate: 638064000)), DataValue(value: 10243.73, date: Date(timeIntervalSinceReferenceDate: 638150400)), DataValue(value: 10351.64, date: Date(timeIntervalSinceReferenceDate: 638236800)), DataValue(value: 10441.52, date: Date(timeIntervalSinceReferenceDate: 638323200)), DataValue(value: 10512.52, date: Date(timeIntervalSinceReferenceDate: 638409600)), DataValue(value: 10563.78, date: Date(timeIntervalSinceReferenceDate: 638496000)), DataValue(value: 10594.48, date: Date(timeIntervalSinceReferenceDate: 638582400)), DataValue(value: 10603.83, date: Date(timeIntervalSinceReferenceDate: 638668800)), DataValue(value: 10591.07, date: Date(timeIntervalSinceReferenceDate: 638755200)), DataValue(value: 10555.47, date: Date(timeIntervalSinceReferenceDate: 638841600)), DataValue(value: 10496.32, date: Date(timeIntervalSinceReferenceDate: 638928000)), DataValue(value: 10412.98, date: Date(timeIntervalSinceReferenceDate: 639014400)), DataValue(value: 10304.83, date: Date(timeIntervalSinceReferenceDate: 639100800)), DataValue(value: 10171.27, date: Date(timeIntervalSinceReferenceDate: 639187200)), DataValue(value: 10011.78, date: Date(timeIntervalSinceReferenceDate: 639273600)), DataValue(value: 9825.86, date: Date(timeIntervalSinceReferenceDate: 639360000)), DataValue(value: 9613.07, date: Date(timeIntervalSinceReferenceDate: 639446400)), DataValue(value: 9373.00, date: Date(timeIntervalSinceReferenceDate: 639532800)), DataValue(value: 9105.31, date: Date(timeIntervalSinceReferenceDate: 639619200)), DataValue(value: 8809.70, date: Date(timeIntervalSinceReferenceDate: 639705600)), DataValue(value: 8485.94, date: Date(timeIntervalSinceReferenceDate: 639792000)), DataValue(value: 8133.84, date: Date(timeIntervalSinceReferenceDate: 639878400)), DataValue(value: 7753.28, date: Date(timeIntervalSinceReferenceDate: 639964800)), DataValue(value: 7344.18, date: Date(timeIntervalSinceReferenceDate: 640051200)), DataValue(value: 6906.56, date: Date(timeIntervalSinceReferenceDate: 640137600)), DataValue(value: 6440.46, date: Date(timeIntervalSinceReferenceDate: 640224000)), DataValue(value: 5946.03, date: Date(timeIntervalSinceReferenceDate: 640310400)), DataValue(value: 5423.45, date: Date(timeIntervalSinceReferenceDate: 640396800)), DataValue(value: 4873.01, date: Date(timeIntervalSinceReferenceDate: 640483200)), DataValue(value: 4295.03, date: Date(timeIntervalSinceReferenceDate: 640569600)), DataValue(value: 3689.94, date: Date(timeIntervalSinceReferenceDate: 640656000)), DataValue(value: 3058.23, date: Date(timeIntervalSinceReferenceDate: 640742400)), DataValue(value: 2400.48, date: Date(timeIntervalSinceReferenceDate: 640828800)), DataValue(value: 1717.33, date: Date(timeIntervalSinceReferenceDate: 640915200)), DataValue(value: 1009.51, date: Date(timeIntervalSinceReferenceDate: 641001600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641088000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641174400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641260800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641347200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641433600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641520000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641606400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641692800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641779200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641865600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 641952000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642038400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642124800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642211200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642297600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642384000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642470400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642556800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642643200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642729600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642816000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642902400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 642988800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643075200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643161600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643248000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643334400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643420800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643507200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643593600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643680000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643766400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643852800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 643939200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644025600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644112000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644198400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644284800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644371200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644457600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644544000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644630400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644716800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644803200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644889600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 644976000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645062400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645148800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645235200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645321600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645408000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645494400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645580800)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645667200)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645753600)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645840000)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 645926400)), DataValue(value: 500.00, date: Date(timeIntervalSinceReferenceDate: 646012800)), DataValue(value: 2457.68, date: Date(timeIntervalSinceReferenceDate: 646099200)), DataValue(value: 5950.37, date: Date(timeIntervalSinceReferenceDate: 646185600)), DataValue(value: 9700.00, date: Date(timeIntervalSinceReferenceDate: 646272000))]

struct ThomasTestGraphData: View {
    
    var colors: [Color] = [.red, .blue, .green, .orange, .gray]
    
    @State var currenColor: Color = .blue
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Début de la période :")
//                Text(DATAVALUES[0].date, style: .date)
                Spacer()
            }
            
            HStack {
                Text("Fin de la période :")
//                Text(DATAVALUES.last!.date, style: .date)
                Spacer()
            }
            
                GrapheViewTest(color: currenColor)
                .frame(width: CGFloat(350), height: CGFloat(250), alignment: .center)
                .cornerRadius(5)
     
                Button(action: {
                var newColor = currenColor
                while currenColor == newColor {
                    newColor = colors.randomElement()!
                }
                currenColor = newColor
            }) {
                Text("Tracer")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(width: 150, height: 44)
                    .background(Color.accentColor)
                    .cornerRadius(12)
            }
            .padding(.top, 20)
        }
    }
}

struct GrapheViewTest: View {
    
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
            
            GrapheTest(progress: layerProgress)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [layerColor, Color.blue]), startPoint: .top, endPoint: .bottom)
                )
            
            GrapheTest(closed: false, progress: layerProgress)
                .stroke(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
                )
            
        }  // ZStack
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

struct GrapheTest: Shape {
    
    var closed = true
    
    // Marges :
    var marginX: Double = 10.00
    var marginY: Double = 10.00
    
    // Taille :
    var width: Double = Double(350)
    var height: Double = Double(250)
    
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
            
           // path.addLine(to: CGPoint(x: getPositionOfTheLastOne(nbOfCompleted: nbOfCompleted, percentOfTheLast: percentOfTheLast).x, y: CGFloat(maxY)))
//
            
            path.addLine(to: CGPoint(x: getPositionOfTheLastOne(nbOfCompleted: nbOfCompleted, percentOfTheLast: percentOfTheLast).x, y: CGFloat(height - marginY)))
            
            path.addLine(to: CGPoint(x: CGFloat(marginX), y: CGFloat(height - marginY)))
            
            path.closeSubpath()
        }
        return path
    }
}

struct ThomasTestGraphData_Previews: PreviewProvider {
    static var previews: some View {
        ThomasTestGraphData()
            .previewDevice("iPhone 11 Pro")
            .preferredColorScheme(.dark)
    }
}


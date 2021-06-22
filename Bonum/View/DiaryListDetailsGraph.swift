//
//  DiaryListDetailsGraph.swift
//  Bonum
//
//  Created by Zoé Hartman on 21/06/2021.
//

import SwiftUI

var LARGEUR: Int = 300
var HAUTEUR: Int = 200

struct DiaryListDetailsGraph: View {
    
    @State var currenColor: Color = .white
    
    var element : DataElement
    
    var colors: [Color] = [.green, .green, .green, .green, .green]
    
    var GraphValues : [Double]{element.values.map{$0.value}}
    
    var body: some View {
        //        VStack{
        //            Text("Analyse de la variable suivie")
        //
        //            Spacer()
        //
        //            ForEach(element.GraphValues, id: \.self){ el in
        //                Text(String(el.value))
        //                Text(dateToString(date: el.date))
        //            }
        //        }
        
        VStack {
            HStack {
                Text("Début de la période :")
                Text(element.values[0].date, style: .date)
            }
            
            if GraphValues.max() != 0 {
                GrapheView(color: currenColor, GraphValues: GraphValues)
                    .frame(width: CGFloat(LARGEUR), height: CGFloat(HAUTEUR), alignment: .center)
                    .cornerRadius(5)
            } else {
                Text("Pas de données")
            }
            
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
    
    var GraphValues : [Double]
    
    init(color: Color, GraphValues : [Double]) {
        _prevColor = State(initialValue: color)
        // en déclarant la prevColor en State sa valeur ne sera pas changée par la vue parente
        self.color = color
        // à l'inverse la color sera updatée si elle change "au dessus"
        self.GraphValues = GraphValues
    }
    
    
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(self.prevColor)
            Graphe(progress: layerProgress, GraphValues: GraphValues)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [layerColor, Color.blue]), startPoint: .top, endPoint: .bottom)
                )
            Graphe(closed: false, progress: layerProgress, GraphValues: GraphValues)
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
    internal init(closed: Bool = true, marginX: Double = 10.00, marginY: Double = 10.00, width: Double = Double(LARGEUR), height: Double = Double(HAUTEUR), progress: CGFloat, GraphValues : [Double]) {
        self.closed = closed
        self.marginX = marginX
        self.marginY = marginY
        self.width = width
        self.height = height
        self.progress = progress
        self.GraphValues = GraphValues
    }
    
    var GraphValues : [Double]
    
    var closed = true
    
    // Marges :
    var marginX: Double = 10.00
    var marginY: Double = 10.00
    
    // Taille :
    var width: Double = Double(LARGEUR)
    var height: Double = Double(HAUTEUR)
    
    var scaleX: Double {
        return (width - marginX) / Double(GraphValues.count)
    }
    
    var scaleY: Double {
        guard let maxY = GraphValues.max() else { return 1 }
        return (height - 2.00 * marginY) / (maxY - minY)
    }
    
    var minY: Double {
        return GraphValues.min() ?? 0.0
    }
    
    var maxY: Double {
        return GraphValues.max() ?? 0.0
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
        guard !GraphValues.isEmpty else { return .zero }
        if index <= 0 {
            return CGPoint(x: CGFloat(marginX), y: CGFloat((height - (GraphValues[0] - minY) * scaleY) - marginY))
        }
        return CGPoint(x: CGFloat(marginX + Double(index) * scaleX), y: CGFloat((height - (GraphValues[index] - minY) * scaleY) - marginY))
    }
    
    // for the last point
    // (sa position dépend de la progression de l'animation)
    func getPositionOfTheLastOne(nbOfCompleted: Int, percentOfTheLast: CGFloat) -> CGPoint {
        let indice = nbOfCompleted
        return CGPoint(x: getPosition(index: indice - 1).x + (getPosition(index: indice).x - getPosition(index: indice - 1).x) * percentOfTheLast, y: getPosition(index: indice - 1).y + (getPosition(index: indice).y - getPosition(index: indice - 1).y) * percentOfTheLast)
    }
    
    func leftToRight(rect: CGRect) -> Path {
        guard progress != 0 else { return Path() }
        let newProgress = progress * CGFloat(GraphValues.count)
        var nbOfCompleted: Int = Int(newProgress)
        if nbOfCompleted == GraphValues.count {
            nbOfCompleted -= 1
        }
        let percentOfTheLast = newProgress - CGFloat(nbOfCompleted)
        
        var path = Path()
        path.move(to: getPosition(index: 0))
        
        // tracer les segments complets
        GraphValues.indices.filter({ $0 < nbOfCompleted }).forEach { indice in
            path.addLine(to: getPosition(index: indice))
        }
        
        // tracer le dernier segment (incomplet)
        path.addLine(to: getPositionOfTheLastOne(nbOfCompleted: nbOfCompleted, percentOfTheLast: percentOfTheLast))
        
        // fermer la forme
        if closed {
            path.addLine(to: CGPoint(x: getPositionOfTheLastOne(nbOfCompleted: nbOfCompleted, percentOfTheLast: percentOfTheLast).x, y: CGFloat(height - marginY)))
            
            path.addLine(to: CGPoint(x: CGFloat(marginX), y: CGFloat(height - marginY)))
            
            path.closeSubpath()
        }
        return path
    }
}

struct DiaryListDetailsGraph_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListDetailsGraph(element: MYSTEPSELEMENT)
    }
}

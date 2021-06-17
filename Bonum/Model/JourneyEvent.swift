//
//  JourneyEvent.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import Foundation

struct JourneyEvent: Hashable {
    
    var title: String
    var date: Date
    var imageName: String?
    var type: Int // généré automatiquement quand user commence/arrête le suivi d'une donnée, ou jalon personnalisé, ou jalon intelligent
    
}

extension JourneyEvent {
    
    static var events: [JourneyEvent] {
        [
            
            JourneyEvent(title: "Début dans la vie active", date: Date(), imageName: "", type: 0),
            JourneyEvent(title: "Inscription à la salle de sport", date: Date(), imageName: "", type: 0),
            JourneyEvent(title: "Accident de la route", date: Date(), imageName: "", type: 0),
            JourneyEvent(title: "Vacances à Lanzarote", date: Date(), imageName: "", type: 0),
            JourneyEvent(title: "Vie à deux", date: Date(), imageName: "", type: 0),
            JourneyEvent(title: "Déménagement", date: Date(), imageName: "", type: 0),
            JourneyEvent(title: "Arrêt de la cigarette", date: Date(), imageName: "", type: 0),
            JourneyEvent(title: "Naissance d'Emilie", date: Date(), imageName: "", type: 0)
            
        ]
    }
    
}


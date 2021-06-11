//
//  JourneyEvent.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import Foundation

struct JourneyEvent {
    
    var title: String
    var date: Date
    var imageName: String?
    var type: Int // généré automatiquement quand user commence/arrête le suivi d'une donnée, ou jalon personnalisé, ou jalon intelligent
    
}

//
//  WilJsonTest.swift
//  Bonum
//
//  Created by Wilfried Roguet on 17/06/2021.
//
//  Cet exemple permet de manipuler un JSON simple dont la structure sera la suivante :
//    {
//        "prenom":             "John",
//        "nom":                "Doe",
//        "dateNaissance":      "2001-06-28"
//    }
//
// Inspirer de : https://learnappmaking.com/codable-json-swift-how-to/
//

import SwiftUI

// On simule ici un fichier JSON qui pourrait être stocké comme un fichier .json ailleurs
let jsonString = """
{
        "prenom":           "John",
        "nom":              "Doe",
        "dateNaissance":    "2001-06-28"
}
"""

// On construit un objet Personne qui map la structure des données du JSON
struct Personne: Codable {
    var prenom: String
    var nom: String
    var dateNaissance: String
//    var dateNaissance: Date
//    var photo: Image
//    var hobbies: String[]
}

// Lectrure du JSON

// turn jsonString into a Data object by calling the data(using:) function on the string.
let jsonData = jsonString.data(using: .utf8)!

// create a JSONDecoder object and immediately call the decode(_:from:) function on it. This turns the jsonData into an object of type User, by decoding the JSON. The User.self type is provided as a parameter.
let personne = try! JSONDecoder().decode(Personne.self, from: jsonData)



// let jsonString2 = String(data: jsonData, encoding: UTF8)


struct WilJsonTest: View {
    var body: some View {
        Text(personne.nom)
    }
}

struct WilJsonTest_Previews: PreviewProvider {
    static var previews: some View {
        WilJsonTest()
    }
}

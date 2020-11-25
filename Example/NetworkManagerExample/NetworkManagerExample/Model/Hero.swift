//
//  Pokemon.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemon = try? newJSONDecoder().decode(Pokemon.self, from: jsonData)

import Foundation

struct Pokemon {
    
    var title: String
    
    var imageData: Data
}

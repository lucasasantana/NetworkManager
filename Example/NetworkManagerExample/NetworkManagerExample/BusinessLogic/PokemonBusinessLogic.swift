//
//  PokemonBusinessLogic.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import Foundation

protocol PokemonBusinessLogicProtocol {
    func loadPokemon(withName pokemonName: String, completion: @escaping (Result<Pokemon, Error>) -> Void)
}

class PokemonBusinessLogic: PokemonBusinessLogicProtocol {
    
    let networkLayer: PokemonNetworkLayer
    
    init(layer: PokemonNetworkLayer = NetworkLayer.shared) {
        self.networkLayer = layer
    }
    
    func loadPokemon(withName pokemonName: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            self?.networkLayer.request(pokemonWithName: pokemonName) { (result) in
                
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}

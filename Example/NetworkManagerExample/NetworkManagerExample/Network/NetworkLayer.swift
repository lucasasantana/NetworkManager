//
//  NetworkLayer.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import Foundation
import NetworkManager

protocol PokemonNetworkLayer {
    func request(pokemonWithName pokemonName: String, completion: @escaping (Result<Pokemon, Error>) -> Void)
}

class NetworkLayer {
    
    fileprivate var manager: NetworkManager = NetworkManager()
    
    static let shared: NetworkLayer = NetworkLayer()
    
    private init() {}
}

extension NetworkLayer: PokemonNetworkLayer {
    
    func request(pokemonWithName pokemonName: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
        let requestModel = PokemonRequest(pokemonName: pokemonName)
        
        manager.request(with: requestModel, cahcePolicy: .useProtocolCachePolicy, timeout: 10.0) { (result) in
            
            switch result {
                
                case .success(let model):
                    
                    do {
                        
                        let pokemon = try model.toPokemon()
                        
                        completion(.success(pokemon))
                        
                    } catch {
                        completion(.failure(error))
                    }
                
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

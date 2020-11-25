//
//  PokemonRequest.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import Foundation
import NetworkManager


struct PokemonEndpoint: NetworkRouterEndpoint {
    
    var baseURL: URL {
        return URL(string: "https://pokeapi.co")!
    }
    
    var path: String {
        return "/api/v2/pokemon/\(pokemonCode)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var pokemonCode: String
    
    init (pokemonName: String) {
        self.pokemonCode = pokemonName
    }
}

struct PokemonRequest: RequestModel {
    
    typealias ResultModel = PokemonDecodable
    
    typealias EndPoint = PokemonEndpoint
    
    var endpoint: PokemonEndpoint {
        return PokemonEndpoint(pokemonName: pokemonCode)
    }
    
    var pokemonCode: String
    
    init(pokemonName: String) {
        self.pokemonCode = pokemonName
    }
}

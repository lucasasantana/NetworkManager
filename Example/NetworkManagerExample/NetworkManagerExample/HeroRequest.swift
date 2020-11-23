//
//  HeroRequest.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import Foundation
import NetworkManager


struct HeroEndpoint: NetworkRouterEndpoint {
    
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443")!
    }
    
    var path: String {
        return "v1/public/characters/1009351"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        
        let parameter: RequestParameters = ["apikey": NetworkLayer.apiKey]
    
        return .requestWithParameters(bodyParameters: nil, urlParameters: parameter)
    }
    
    var heroCode: Int
    
    init (heroCode: Int) {
        self.heroCode = heroCode
    }
}

struct HeroRequest: RequestModel {
    
    typealias ResultModel = HeroDecodable
    
    typealias EndPoint = HeroEndpoint
    
    var endpoint: HeroEndpoint {
        return HeroEndpoint(heroCode: heroCode)
    }
    
    var heroCode: Int
    
    init(heroCode: Int) {
        self.heroCode = heroCode
    }
}

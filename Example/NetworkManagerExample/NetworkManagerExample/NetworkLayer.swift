//
//  NetworkLayer.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import Foundation
import NetworkManager

protocol HeroNetworkLayer {
    func request(heroWithCode heroCode: Int, completion: @escaping (Result<Hero, Error>) -> Void)
}

class NetworkLayer {
    
    fileprivate var manager: NetworkManager = NetworkManager()
    
    let shared: NetworkLayer = NetworkLayer()
    
    static let apiKey = "46f88463a94d916b176b8d478243c2fc"
    
    private init() {}
}

extension NetworkLayer: HeroNetworkLayer {
    
    
    func request(heroWithCode heroCode: Int, completion: @escaping (Result<Hero, Error>) -> Void) {
        
        let requestModel = HeroRequest(heroCode: heroCode)
        
        
        
        
    }
    
    
}

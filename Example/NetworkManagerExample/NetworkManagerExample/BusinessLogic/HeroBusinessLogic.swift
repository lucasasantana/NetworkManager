//
//  HeroBusinessLogic.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import Foundation

protocol HeroBusinessLogicProtocol {
    func loadHero(withCode heroCode: Int, completion: @escaping (Result<Hero, Error>) -> Void)
}

class HeroBusinessLogic: HeroBusinessLogicProtocol {
    
    let networkLayer: HeroNetworkLayer
    
    init(layer: HeroNetworkLayer = NetworkLayer.shared) {
        self.networkLayer = layer
    }
    
    func loadHero(withCode heroCode: Int, completion: @escaping (Result<Hero, Error>) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            self?.networkLayer.request(heroWithCode: heroCode) { (result) in
                
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}

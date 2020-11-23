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
    
    static let shared: NetworkLayer = NetworkLayer()
    
    // May have to generate one at https://developer.marvel.com
    static let apiKey = "46f88463a94d916b176b8d478243c2fc"
    
    private init() {}
}

extension NetworkLayer: HeroNetworkLayer {
    
    func request(heroWithCode heroCode: Int, completion: @escaping (Result<Hero, Error>) -> Void) {
        
        let requestModel = HeroRequest(heroCode: heroCode)
        
        manager.request(with: requestModel, cahcePolicy: .useProtocolCachePolicy, timeout: 10.0) { (result) in
            
            switch result {
                
                case .success(let model):
                    
                    do {
                        
                        let hero = try model.toHero()
                        
                        completion(.success(hero))
                        
                    } catch {
                        completion(.failure(error))
                    }
                
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

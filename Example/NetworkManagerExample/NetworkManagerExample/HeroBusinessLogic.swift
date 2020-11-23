//
//  HeroBusinessLogic.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import Foundation

protocol HeroBusinessLogicProtocol {
    func loadHero(completion: @escaping ()->Void)
}

class HeroBusinessLogic: HeroBusinessLogicProtocol {
    
    func loadHero(completion: @escaping () -> Void) {
        
    }
}

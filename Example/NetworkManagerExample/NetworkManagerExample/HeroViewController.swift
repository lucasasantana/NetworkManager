//
//  HeroViewController.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import UIKit

class HeroViewController: UIViewController {
    
    var heroView: HeroView {
        return view as! HeroView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heroView.delegate = self
        heroView.emptyContent()
        
    }
}

extension HeroViewController: HeroViewDelegate {
    
    func heroViewDidTapButton() {
        
    }
}


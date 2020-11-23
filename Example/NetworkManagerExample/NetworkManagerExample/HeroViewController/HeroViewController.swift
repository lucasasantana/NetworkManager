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
    
    var heroBusinessLogic: HeroBusinessLogicProtocol = HeroBusinessLogic()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heroView.delegate = self
        heroView.emptyContent()
        
    }
    
    func presentAlert(of error: Error) {
        
        let controller = UIAlertController(
            title: "OPS",
            message: "Something went wrong with the request: \(error.localizedDescription)",
            preferredStyle: .alert)
        
        
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(controller, animated: true, completion: nil)
    }
    
    func presetLoadAlert() {
        
        let controller = UIAlertController(
            title: "Loading hero...",
            message: nil,
            preferredStyle: .alert)
        
        
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(controller, animated: true, completion: nil)
    }
}

extension HeroViewController: HeroViewDelegate {
    
    func heroViewDidTapButton() {
        
        presetLoadAlert()
        
        heroBusinessLogic.loadHero(withCode: 1009351) { [weak self] (result) in
            
            self?.presentedViewController?.dismiss(animated: true, completion: nil)
            
            switch result {
                
                case .success(let hero):
                    
                    let image = UIImage(data: hero.imageData)
                    
                    self?.heroView.display(title: hero.title, image: image)
                    
                case .failure(let error):
                    self?.presentAlert(of: error)
            }
        }
    }
}


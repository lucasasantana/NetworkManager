//
//  PokemonViewController.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemonView: PokemonView {
        return view as! PokemonView
    }
    
    var pokemonBusinessLogic: PokemonBusinessLogicProtocol = PokemonBusinessLogic()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pokemonView.delegate = self
        pokemonView.emptyContent()
        
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
            title: "Loading pokemon...",
            message: nil,
            preferredStyle: .alert)
        
        present(controller, animated: true, completion: nil)
    }
}

extension PokemonViewController: PokemonViewDelegate {
    
    func pokemonViewDidTapButton() {
        
        presetLoadAlert()
        
        pokemonBusinessLogic.loadPokemon(withName: "ditto") { [weak self] (result) in
            
            self?.presentedViewController?.dismiss(animated: true, completion: nil)
            
            switch result {
                
                case .success(let pokemon):
                    
                    let image = UIImage(data: pokemon.imageData)
                    
                    self?.pokemonView.display(title: pokemon.title, image: image)
                    
                case .failure(let error):
                    self?.presentAlert(of: error)
            }
        }
    }
}


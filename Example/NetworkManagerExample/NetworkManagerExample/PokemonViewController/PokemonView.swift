//
//  PokemonView.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import UIKit

protocol PokemonViewDelegate: AnyObject {
    func pokemonViewDidTapButton()
}

class PokemonView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: PokemonViewDelegate?
    
    
    func emptyContent() {
        
        self.imageView.isHidden = true
        self.label.isHidden = true
        
        self.button.setTitle("Load pokemon!", for: .normal)
    }
    
    func display(title: String, image: UIImage?) {
        
        self.imageView.image = image
        self.imageView.isHidden = image == nil
        
        self.label.text = title
        self.label.isHidden = false
        
        self.button.setTitle("Reload pokemon!", for: .normal)
    }
    
    @IBAction func handleButtonTap(_ sender: UIButton) {
        delegate?.pokemonViewDidTapButton()
    }
}

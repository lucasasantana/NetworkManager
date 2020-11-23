//
//  HeroView.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//

import UIKit

protocol HeroViewDelegate: AnyObject {
    func heroViewDidTapButton()
}

class HeroView: UIView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: HeroViewDelegate?
    
    
    func emptyContent() {
        
        self.image.isHidden = true
        self.label.isHidden = true
        
        self.button.setTitle("Load hero!", for: .normal)
    }
    
    @IBAction func handleButtonTap(_ sender: UIButton) {
        delegate?.heroViewDidTapButton()
    }
}

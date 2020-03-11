//
//  OptionsView.swift
//  marvel-project
//
//  Created by Gerson Vieira on 10/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class OptionsView: NibView {
    
    @IBOutlet weak var optionLabel: UIButton!
    var delegate: CharacterDetailDelegate?
    var option: OptionsEnum = .comics
    var data: urlOptions?
    
    required init(with type: OptionsEnum, data: urlOptions?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.option = type
        self.data = data
        switch type {
        case .comics:
            optionLabel.setTitle("Comics", for: .normal)
            optionLabel.setTitleColor(UIColor.black, for: .normal)
        case .detail:
            optionLabel.setTitle("Detail", for: .normal)
            optionLabel.setTitleColor(UIColor.link, for: .normal)
        case .wiki:
            optionLabel.setTitle("Wiki", for: .normal)
            optionLabel.setTitleColor(UIColor.link, for: .normal)
        case .comiclink:
            optionLabel.setTitle("Comic Link", for: .normal)
            optionLabel.setTitleColor(UIColor.link, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func choiceAction(_ sender: Any) {
        delegate?.navigateTo(type: option, data: data)
    }
}


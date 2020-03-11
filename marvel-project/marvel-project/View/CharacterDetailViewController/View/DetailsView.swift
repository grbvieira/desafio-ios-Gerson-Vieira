//
//  DetailsView.swift
//  marvel-project
//
//  Created by Gerson Vieira on 10/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class DetailsView: NibView {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init(with data: CharactersViewModel) {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        descriptionLabel.text = data.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

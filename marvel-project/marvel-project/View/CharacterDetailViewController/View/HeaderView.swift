//
//  HeaderView.swift
//  marvel-project
//
//  Created by Gerson Vieira on 10/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher

class HeaderView: NibView {
    
    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    
    required init(with data: CharactersViewModel) {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        thumImage.kf.setImage(with: data.thumbnail)
        nameLabel.text = data.name
        issueLabel.text = String(data.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}

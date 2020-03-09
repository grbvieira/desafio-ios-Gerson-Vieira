//
//  CharactersCell.swift
//  marvel-project
//
//  Created by Gerson Vieira on 08/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher

class CharactersCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    func fillCell(data: CharactersViewModel) {
        self.thumbnail.kf.setImage(with: data.thumbnail)
        self.nameLbl.text = data.name
    }
}

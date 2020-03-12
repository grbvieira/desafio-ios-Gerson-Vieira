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
    let processor = RoundCornerImageProcessor(cornerRadius: 20)
    
    func fillCell(data: CharactersViewModel) {
        self.thumbnail.kf.setImage(with: data.thumbnail,
                                  options: [
                                    .processor(processor),
                                    .scaleFactor(UIScreen.main.scale),
                                    .transition(.fade(1)),
                                    .cacheOriginalImage
        ])
        self.nameLbl.text = data.name
    }
}

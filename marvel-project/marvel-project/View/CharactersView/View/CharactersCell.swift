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
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func fillCell(data: CharactersViewModel) {
        self.photo.kf.setImage(with: data.thumbnail)
        self.name.text = data.name
    }
}

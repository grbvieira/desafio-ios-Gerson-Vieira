//
//  CommicsView.swift
//  marvel-project
//
//  Created by Gerson Vieira on 09/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher

class ComicsCell: UITableViewCell {
    
    @IBOutlet weak var thumbComic: UIImageView!
    @IBOutlet weak var nameComic: UILabel!
    @IBOutlet weak var issueComic: UILabel!
    @IBOutlet weak var onSaleDate: UILabel!
    
    func setup(data: ComicsViewModel) {
        self.thumbComic.kf.setImage(with: data.thumbnail)
        self.nameComic.text = data.title
        self.issueComic.text = data.issue
        self.onSaleDate.text = data.onsaleDate
    }
}

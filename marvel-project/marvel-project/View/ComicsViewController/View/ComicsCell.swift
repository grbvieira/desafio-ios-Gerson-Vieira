//
//  CommicsView.swift
//  marvel-project
//
//  Created by Gerson Vieira on 09/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher

class ComicsView: NibView {
    
    @IBOutlet weak var thumbComic: UIImageView!
    @IBOutlet weak var nameComic: UILabel!
    
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(data: ComicsViewModel) {
        self.thumbComic.kf.setImage(with: data.thumbnail)
        self.nameComic.text = data.title
    }
}

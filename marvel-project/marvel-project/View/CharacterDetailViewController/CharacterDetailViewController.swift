//
//  CharacterDetailViewController.swift
//  marvel-project
//
//  Created by Gerson Vieira on 08/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: BaseViewController {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var data: CharactersViewModel!
    
    required init(data: CharactersViewModel) {
        super.init(nibName: "CharacterDetailViewController", bundle: nil)
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.characterImage.kf.setImage(with: data?.thumbnail)
        self.descriptionLabel.text = data?.description
    }
    
    
    @IBAction func seeComicsAction(_ sender: Any) {
        guard let navigation = self.navigationController else { return }
        let coordinator = ComicsCoordinator(with: navigation, id: data.id)
        coordinator.start(presentation: .present(animated: true))
    }
}

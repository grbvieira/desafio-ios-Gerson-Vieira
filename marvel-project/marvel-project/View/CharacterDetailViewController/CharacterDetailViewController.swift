//
//  CharacterDetailViewController.swift
//  marvel-project
//
//  Created by Gerson Vieira on 08/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher

enum OptionsEnum {
    case comics
}
protocol CharacterDetailDelegate {
    func navigateTo(type: OptionsEnum)
}

class CharacterDetailViewController: BaseViewController, CharacterDetailDelegate {
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var customViewBackgrpund: UIView!
    
    var mainStack = UIStackView()
    let scrollView = UIScrollView()
    
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
        setupStack()
        setupUI()
    }
    
    func cleanStack() {
        mainStack.subviews.forEach({
            $0.removeFromSuperview()
        })
    }
    func setupUI() {
        cleanStack()
        guard let data = data else { return }
        
        setHeaderView()
        if data.description != String() {
            setDetailView()
        }
        setOptions(type: .comics)
    }
    
    func setHeaderView() {
        let headerView = HeaderView(with: data)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: 254).isActive = true
        mainStack.addArrangedSubview(headerView)
    }
    
    func setDetailView() {
        let detailView = DetailsView(with: data)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.heightAnchor.constraint(equalToConstant: 152).isActive = true
        mainStack.addArrangedSubview(detailView)
    }
    
    func setOptions(type: OptionsEnum) {
        let optionsView = OptionsView(with: type)
        optionsView.delegate = self
        optionsView.translatesAutoresizingMaskIntoConstraints = false
        optionsView.heightAnchor.constraint(equalToConstant: 107).isActive = true
        mainStack.addArrangedSubview(optionsView)
        
    }
    
    func navigateTo(type: OptionsEnum) {
        guard let navigation = self.navigationController else { return }
        switch type {
        case .comics:
            let coordinator = ComicsCoordinator(with: navigation, id: data.id)
            coordinator.start(presentation: .push(animated: true))
        }
    }
}

extension CharacterDetailViewController {
    
    func setupStack() {
        self.createScroll()
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fillProportionally
        mainStack.spacing = 2
        self.scrollView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func createScroll() {
        customViewBackgrpund.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: customViewBackgrpund.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: customViewBackgrpund.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: customViewBackgrpund.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: customViewBackgrpund.bottomAnchor)
        ])
    }
}

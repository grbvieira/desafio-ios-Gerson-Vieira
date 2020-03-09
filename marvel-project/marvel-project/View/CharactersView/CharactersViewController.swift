//
//  CharactersViewController.swift
//  marvel-project
//
//  Created by Gerson Vieira on 07/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Request<T> {
    case none
    case loading
    case success(T)
    case failure(String)
}

class CharactersViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var disposeBag: DisposeBag!
    private let fetch = CharactersProvider()
    var viewModel: [CharactersViewModel] = []
    var charactersResponse: Request<[CharactersModel]> = .none {
        didSet { reloadData() }
    }
    
    required init() {
        super.init(nibName: "CharactersViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
    
    func fetchCharacters() {
        disposeBag = DisposeBag()
        charactersResponse = .loading
        fetch.resquestCharacters()
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    self.charactersResponse = .success([response])
                case .error(let error):
                    self.charactersResponse = .failure(error.localizedDescription)
                }
        }.disposed(by: disposeBag)
    }
    
    func reloadData() {
        switch charactersResponse {
        case .none:
            return
        case .loading:
            return
        case .success(let response):
            let viewModel = FillViewModel().wrapToViewModel(model: response[0])
            self.viewModel = viewModel
        case .failure(let error):
            alert(message: error)
        }
    }
    
    func alert(message: String) {
         let alert = UIAlertController(title: "Alert", message: "Error: \(message)",
             preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
}

extension CharactersViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell", for: indexPath) as? CharactersCell else {
            return UICollectionViewCell()
        }
        cell.fillCell(data: viewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigation = self.navigationController else { return }
        let coordinator = CharacterDetailCoordinator(with: navigation, id: viewModel[indexPath.row].id)
        coordinator.start(presentation: .push(animated: true))
          // self.navigateTo(id: movies[indexPath.row].id)
        print("Selecionado")
    }
}

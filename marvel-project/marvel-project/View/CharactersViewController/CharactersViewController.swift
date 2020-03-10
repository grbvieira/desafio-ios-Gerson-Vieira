//
//  CharactersViewController.swift
//  marvel-project
//
//  Created by Gerson Vieira on 07/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import RxSwift
import RxCocoa

class CharactersViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var refreshControl:UIRefreshControl!
    private var disposeBag: DisposeBag!
    private let fetch = MarvelProjectProvider()
    var viewModel: [CharactersViewModel] = []
    var charactersResponse: Request<[CharactersModel]> = .none {
        didSet { reloadData() }
    }
    var isLoading: Bool = false
    var offSet = 0
    
    required init() {
        super.init(nibName: "CharactersViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFiles()
        fetchCharacters()
        setupRefresh()
    }
    
    func fetchCharacters() {
        disposeBag = DisposeBag()
        charactersResponse = .loading
        isLoading = true
        fetch.resquestCharacters(offSet: offSet)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    self.isLoading = false
                    self.charactersResponse = .success([response])
                case .error(let error):
                    self.isLoading = false
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
            let viewModel = FillViewModel().wrapToCharactersViewModel(model: response[0])
            self.viewModel.append(contentsOf: viewModel)
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        case .failure(let error):
            alert(message: error)
        }
    }
    
    private func alert(message: String) {
        let alert = UIAlertController(title: "Alert", message: "Error: \(message)",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func registerNibFiles(){
        let cell = UINib(nibName: "CharactersCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "charactersCell")
    }
    
}

extension CharactersViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charactersCell", for: indexPath) as? CharactersCell else {
            return UICollectionViewCell()
        }
        cell.fillCell(data: viewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigation = self.navigationController else { return }
        let coordinator = CharacterDetailCoordinator(with: navigation, viewModel: viewModel[indexPath.row])
        coordinator.start(presentation: .push(animated: true))
    }
}

extension CharactersViewController {
    
    func setupRefresh() {
        self.refreshControl = UIRefreshControl()
        //self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(CharactersViewController.refresh), for: .valueChanged)
        collectionView!.addSubview(refreshControl)
    }
    
    @objc private func refresh(sender:AnyObject)
    {
        fetchCharacters()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            guard !self.isLoading else { return }
            offSet = offSet + 20
            fetchCharacters()
            
        }
    }
}

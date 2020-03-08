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

class CharactersViewController: BaseViewController<CharactersView> {
    
    private var disposeBag: DisposeBag!
    private let fetch = CharactersProvider()
    var charactersResponse: Request<[CharactersModel]> = .none {
        didSet { reloadStack() }
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
                // self.fetching = false
                case .error(let error):
                    self.charactersResponse = .failure(error.localizedDescription)
                    // self.fetching = false
                }
        }.disposed(by: disposeBag)
    }
    
    func reloadStack() {
        
    }
}

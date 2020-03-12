//
//  ComicsViewController.swift
//  marvel-project
//
//  Created by Gerson Vieira on 09/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import RxSwift
import RxCocoa

class ComicsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var disposeBag: DisposeBag!
    private let fetch = MarvelProjectProvider()
    private var indicator = UIActivityIndicatorView()
    var viewModel: [ComicsViewModel] = []
    var comicsResponse: Request<[ComicsModel]> = .none {
        didSet { reloadData() }
    }
    var isLoading: Bool = false
    var offSet = 20
    var id = 0
    var total = 0
    
    required init(id: Int) {
        super.init(nibName: "ComicsViewController", bundle: nil)
        self.id = id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Comics"
        activityIndicator()
        registerCell()
        fechComics()
    }
    
    private func registerCell() {
        let cell = UINib(nibName: "ComicsCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "ComicsCell")
    }

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.backgroundColor = .darkGray
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    func fechComics() {
        disposeBag = DisposeBag()
        comicsResponse = .loading
        isLoading = true
        
        fetch.requestComics(id: id)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    self.isLoading = false
                    if (response.data?.results!.isEmpty)! {
                        self.comicsResponse = .failure("Não há HQ's para este personagem")
                    }
                    self.comicsResponse = .success([response])
                case .error(let error):
                    self.isLoading = false
                    self.comicsResponse = .failure(error.localizedDescription)
                }
        }.disposed(by: disposeBag)
    }
    
    func reloadData() {
        switch comicsResponse {
        case .none: return
        case .loading: indicator.startAnimating()
        case .success(let data):
            indicator.stopAnimating()
            total = data[0].data?.total ?? 0
            let viewModel = FillViewModel().wrapToComicsViewModel(model: data[0])
            self.viewModel.append(contentsOf: viewModel)
            self.tableView.reloadData()
        case .failure(let error):
            indicator.stopAnimating()
            alert(message: error)
        }
    }
    
    private func alert(message: String) {
        let alert = UIAlertController(title: "Alert", message: "Error: \(message)",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { alert in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ComicsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsCell", for: indexPath) as? ComicsCell else
        { return UITableViewCell() }
        
        cell.setup(data: viewModel[indexPath.row])
        
        return cell
    }
    
    
}

extension ComicsViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            guard !self.isLoading else { return }
            if total < offSet {
                offSet = offSet + 20
                fechComics()
            }
        }
    }
}

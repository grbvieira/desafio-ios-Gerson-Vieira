//
//  CharactersViewModel.swift
//  marvel-project
//
//  Created by Gerson Vieira on 08/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class CharactersViewModel {
    
    private var entry: Result?
    
    init(entry: Result) {
        self.entry = entry
    }
    
    var id: Int {
        let id = entry?.id ?? 0
        return id
    }
    
    var name: String {
        let name = entry?.name ?? String()
        return name
    }
    
    var thumbnail: URL {
        let path = entry?.thumbnail?.path ?? String()
        let exten = entry?.thumbnail?.thumbnailExtension?.rawValue ?? String()
        let str = "\(path).\(exten)"
        let url = URL(string: str)
        return url!
    }
}

class FillViewModel {
    func wrapToViewModel(model: CharactersModel) -> [CharactersViewModel] {
        var characters = [CharactersViewModel]()
        guard let items = model.data?.results else {
            return characters
        }
        for item in items {
            let viewModel = CharactersViewModel(entry: item)
            characters.append(viewModel)
        }
        return characters
    }
}

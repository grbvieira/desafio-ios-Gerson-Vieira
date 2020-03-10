//
//  FillViewModel.swift
//  marvel-project
//
//  Created by Gerson Vieira on 09/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation
class FillViewModel {
    func wrapToCharactersViewModel(model: CharactersModel) -> [CharactersViewModel] {
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
    
    func wrapToComicsViewModel(model: ComicsModel) -> [ComicsViewModel] {
        var comics = [ComicsViewModel]()
        guard let items = model.data?.results else {
            return comics
        }
        for item in items {
            let viewModel = ComicsViewModel(entry: item)
            comics.append(viewModel)
        }
        return comics
    }
}

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
    
    var description: String {
        let description = entry?.resultDescription ?? String()
        return description
    }
    
    var thumbnail: URL {
        let path = entry?.thumbnail?.path ?? String()
        let exten = entry?.thumbnail?.thumbnailExtension?.rawValue ?? String()
        let str = "\(path).\(exten)"
        let url = URL(string: str)
        return url!
    }
}

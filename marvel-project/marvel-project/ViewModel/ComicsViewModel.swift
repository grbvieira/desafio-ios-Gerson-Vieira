//
//  ComicsViewModel.swift
//  marvel-project
//
//  Created by Gerson Vieira on 09/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation
class ComicsViewModel {
    
    private var entry: ResultComics?
    
    init(entry: ResultComics) {
        self.entry = entry
    }
    
    var title: String {
        let name = entry?.title ?? String()
        return name
    }
    
    
    var thumbnail: URL {
        let path = entry?.thumbnail?.path ?? String()
        let exten = entry?.thumbnail?.thumbnailExtension.rawValue ?? String()
        let str = "\(path).\(exten)"
        let url = URL(string: str)
        return url!
    }
    
    var issue: String {
        guard let issue = entry?.issueNumber else
        { return String() }
        let srt = "Issue #\(issue)"
        return srt
    }
}

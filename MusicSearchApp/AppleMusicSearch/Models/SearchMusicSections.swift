//
//  SectionMusic.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import Foundation

import RxDataSources
import RxSwift

// MARK: - SectionModel
enum SearchMusicSections {
    case countSection([MusicItem])
    case musicSection([MusicItem])
}

extension SearchMusicSections: SectionModelType {
    typealias Item = MusicItem
    
    var items: [MusicItem] {
        switch self {
        case let .countSection(count):
            return count
        case let .musicSection(items):
            return items
        }
    }
    
    init(original: SearchMusicSections, items: [MusicItem]) {
        switch original {
        case let .countSection(items):
            self = .countSection(items)
        case let .musicSection(items):
            self = .musicSection(items)
        }
    }
}

enum MusicItem {
    case countItem(count: Int)
    case musicItem(Music)
}

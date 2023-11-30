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
enum SectionOfMusic {
    case musicSection([MusicItem])
}

extension SectionOfMusic: SectionModelType {
    typealias Item = MusicItem
    
    var items: [MusicItem] {
        switch self {
        case let .musicSection(items):
            return items
        }
    }
    
    init(original: SectionOfMusic, items: [MusicItem]) {
        switch original {
        case let .musicSection(items):
            self = .musicSection(items)
        }
    }
}

enum MusicItem {
    case musicItem(Music)
}

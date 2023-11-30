//
//  MusicCellReactor.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import Foundation

import ReactorKit
import RxSwift

final class MusicCellReactor: Reactor {
    typealias Action = NoAction
    
    var initialState: Music
    
    init(state: Music) {
        self.initialState = state
    }
}

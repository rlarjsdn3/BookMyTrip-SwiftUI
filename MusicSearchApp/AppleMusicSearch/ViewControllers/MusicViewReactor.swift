//
//  MusicViewReactor.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import UIKit

import ReactorKit
import RxSwift

final class MusicViewReactor: Reactor {
    // MARK: - Action
    enum Action { 
        case didChangeText(String)
    }
    
    // MARK: - Mutation
    enum Mutation {
        case updateSearchResult([SectionOfMusic])
    }
    
    // MARK: - State
    struct State { 
        var sectionedMusic: [SectionOfMusic]
    }
    
    // MARK: - PROPERTIES
    let provider: ServiceProviderType
    var initialState: State
    
    // MARK: - Intializer
    init() {
        self.provider = ServiceProvider()
        self.initialState = State(sectionedMusic: [.musicSection([])])
    }
    
    // MARK: - Helpers
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didChangeText(query):
            return provider.musicAPIService.requestMusicSearch(query)
                .map { items in
                    let musicItems = items.results.map { MusicItem.musicItem($0) }
                    let sectionOfMusic = [SectionOfMusic.musicSection(musicItems)]
                    return Mutation.updateSearchResult(sectionOfMusic)
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .updateSearchResult(sectionOfMusic):
            newState.sectionedMusic = sectionOfMusic
        }
        return newState
    }
}

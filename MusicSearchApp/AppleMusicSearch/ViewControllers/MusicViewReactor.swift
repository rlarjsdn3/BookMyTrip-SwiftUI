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
        case updateSearchResult([SearchMusicSections], [SearchMusicSections])
    }
    
    // MARK: - State
    struct State {
        var sectionedMusic: [SearchMusicSections]
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
                    let countItem = [MusicItem.countItem(count: items.resultCount)]
                    let countSection = [SearchMusicSections.countSection(countItem)]
                    
                    let musicItems = items.results.map { MusicItem.musicItem($0) }
                    let musicSection = [SearchMusicSections.musicSection(musicItems)]
                    
                    return  Mutation.updateSearchResult(countSection, musicSection)
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.sectionedMusic = []
        switch mutation {
        case let .updateSearchResult(sectionOfCount, sectionOfMusic):
            newState.sectionedMusic.append(contentsOf: sectionOfCount)
            newState.sectionedMusic.append(contentsOf: sectionOfMusic)
        }
        return newState
    }
}

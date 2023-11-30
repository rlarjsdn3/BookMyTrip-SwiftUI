//
//  ApiService.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import Foundation

import ReactorKit
import RxSwift

protocol MusicAPIServiceType {
    func requestMusicSearch(_ query: String) -> Observable<QueryResult>
}

final class MusicAPIService: BaseService, MusicAPIServiceType {
    func requestMusicSearch(_ query: String) -> Observable<QueryResult> {
        guard let url = makeUrl(query) else { return .empty() }
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { [weak self] data in
                guard let safeData = self?.decode(of: QueryResult.self, from: data) else {
                    print("파싱 실패")
                    return .init(resultCount: 0, results: [])
                }
                return safeData
            }
    }
    
    private func makeUrl(_ query: String) -> URL? {
        return URL(string: "https://itunes.apple.com/search?term=\(query)&country=US")
    }
    
    private func decode<T>(of type: T.Type, from data: Data) -> T? where T: Decodable {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
}

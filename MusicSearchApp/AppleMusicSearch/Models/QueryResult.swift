// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Music
struct QueryResult: Codable {
    let resultCount: Int
    let results: [Music]
}

// MARK: - Result
struct Music: Codable {
    let artistName: String?
    let albumName: String?
    let songName: String?
    let coverImageUrl: String?

    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName = "collectionName"
        case songName = "trackName"
        case coverImageUrl = "artworkUrl100"
    }
}

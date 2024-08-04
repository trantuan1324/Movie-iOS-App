//
//  Movie.swift
//  Movie App
//
//  Created by Trần Quang Tuấn on 3/8/24.
//

import Foundation

struct Title: Codable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAvg: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview = "overview"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAvg = "vote_average"
    }
}

struct TitleDataList: Codable {
    let results: [Title]
}


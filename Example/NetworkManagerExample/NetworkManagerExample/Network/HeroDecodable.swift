//
//  HeroDecodable.swift
//  NetworkManagerExample
//
//  Created by Lucas Antevere Santana on 23/11/20.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.


import Foundation

enum HeroError: Error {
    case emptyData
    case invalidImageURL
}

// MARK: - Hero
struct HeroDecodable: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
    
    func toHero() throws -> Hero {
        
        guard let content = data.results.first else {
            throw HeroError.emptyData
        }
        
        let title = content.name
        
        let imagePath = "\(content.thumbnail.path).\(content.thumbnail.thumbnailExtension)"
        
        guard let imageURL = URL(string: imagePath) else {
            throw HeroError.invalidImageURL
        }
        
        let imageData = try Data(contentsOf: imageURL)
        
        return Hero(title: title, imageData: imageData)
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [HeroResult]
}

// MARK: - Result
struct HeroResult: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: Date
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}


//
//  FilmForHeader.swift
//  MovieApp
//
//  Created by Илья Канторин on 28.03.2024.
//

import Foundation

struct HeaderFilmsResponse: Codable {
    let items: [Film]
}

struct Film: Codable {
    let kinopoiskId: Int
    let nameRu: String
    let posterUrl: String
}

struct FilmDescription: Codable{
    let description: String
    let shortDescription: String
    
}

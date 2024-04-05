//
//  FilmForHeader.swift
//  MovieApp
//
//  Created by Илья Канторин on 28.03.2024.
//

import Foundation

struct HeaderFilmsResponse: Decodable {
    let items: [Film]
}

struct Film: Decodable {
    let kinopoiskId: Int
    let nameRu: String
    let posterUrl: String
    let countries: [Country]
    let genres: [Genre]
    let year: Int
}

struct FilmDescription: Decodable{
    let description: String
    let shortDescription: String
    
}

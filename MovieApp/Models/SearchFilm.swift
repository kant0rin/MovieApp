//
//  SearchFilm.swift
//  MovieApp
//
//  Created by Илья Канторин on 02.04.2024.
//

import Foundation

struct SearchFilmResponse: Decodable {
    let films: [SearchFilm]
}

struct SearchFilm: Decodable {
    let filmId: Int
    let nameRu: String
    let year: String
    let rating: String
    let posterUrl: String
    
}

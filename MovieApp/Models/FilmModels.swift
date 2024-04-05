//
//  FilmModels.swift
//  MovieApp
//
//  Created by Илья Канторин on 30.03.2024.
//

import Foundation

enum FilmSections {
    case main
    case trailer
    case simmilar
}

enum FilmRow: Hashable {
    case main(FullFilm)
    case trailer(Trailer)
    case simmilar(SimmilarResponse)
}


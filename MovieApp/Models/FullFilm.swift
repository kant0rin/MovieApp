//
//  FullFilm.swift
//  MovieApp
//
//  Created by Илья Канторин on 28.03.2024.
//

import Foundation

struct FullFilm: Decodable, Hashable {
    let kinopoiskId: Int
    let nameRu: String
    let filmLength: Int
    let year: Int
    let ratingAgeLimits: String?
    let description: String
    let posterUrl: String
    
    static var moc = FullFilm(kinopoiskId: 1346358, nameRu: "Летучий корабль", filmLength: 100, year:2024, ratingAgeLimits: "age6", description: "Царь собирается выдать свою дочь Забаву за обворожительного красавчика Поля, богатого наследника с заграничным лоском. Вот только царевна хочет выйти замуж по любви. Ее неожиданное знакомство с простым, но честным и обаятельным матросом Иваном вносит смуту в планы Поля заполучить корону. Влюбленный в царевну Иван с помощью обитателей волшебного леса строит Летучий корабль, чтобы улететь на нем вместе с любимой. Отважному матросу предстоит сразиться с хитрецом-Полем, который использует против Ивана тёмную магию. Но настоящая любовь окажется сильнее: злодей будет наказан, а Иван вместе с Забавой ступят на борт Летучего корабля и унесутся вперед, за новой мечтой.", posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/1346358.jpg")
}

struct SimmilarResponse: Decodable, Hashable {
    let items: [Simmilar]
    
    static let moc = SimmilarResponse(items: [Simmilar(filmId: 377, posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/377.jpg"),Simmilar(filmId: 377, posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/377.jpg"),Simmilar(filmId: 377, posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/377.jpg"),Simmilar(filmId: 377, posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/377.jpg"),Simmilar(filmId: 377, posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/377.jpg"), ])
    
}

struct Simmilar: Decodable, Hashable {
    let filmId: Int
    let posterUrl: String
}

struct TrailersResponse: Decodable, Hashable {
    let items: [Trailer]

}

struct Trailer: Decodable, Hashable {
    let url: String
    
    static var moc = Trailer(url: "https://widgets.kinopoisk.ru/discovery/trailer/13556?onlyPlayer=1&autoplay=1&cover=1")
}

struct Country: Decodable {
    let country: String
}

struct Genre: Decodable {
    let genre: String
}

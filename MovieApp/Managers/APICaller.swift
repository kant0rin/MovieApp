//
//  APICaller.swift
//  MovieApp
//
//  Created by Илья Канторин on 28.03.2024.
//

import UIKit


private enum Constans: String {
    case API_KEY = "621838e5-4c7b-41b4-836a-8cd6d1518834"
    case BASE_URL = "https://kinopoiskapiunofficial.tech/api/v2.2/"
    case URL_FOR_SEARCH = "https://kinopoiskapiunofficial.tech/api/v2.1/"
}

private enum APIError: Error {
    case failedToGetData
}

final class APICaller {
    static let shared = APICaller(); private init(){}
    
    func getFilmsForHeader(_ completion: @escaping (Result<[Film], Error>) -> Void){
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/collections?type=TOP_POPULAR_MOVIES&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(HeaderFilmsResponse.self, from: data)
                completion(.success(results.items))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func getPopularFilms(_ completion: @escaping (Result<[Film], Error>) -> Void){
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/collections?type=TOP_250_MOVIES&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(HeaderFilmsResponse.self, from: data)
                completion(.success(results.items))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPremiers(_ completion: @escaping (Result<[Film], Error>) -> Void){
        
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/premieres?year=2024&month=APRIL") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(HeaderFilmsResponse.self, from: data)
                completion(.success(results.items))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getLoveFilms(_ completion: @escaping (Result<[Film], Error>) -> Void){
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/collections?type=LOVE_THEME&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(HeaderFilmsResponse.self, from: data)
                completion(.success(results.items))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPopularSerials(_ completion: @escaping (Result<[Film], Error>) -> Void){
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/collections?type=TOP_250_TV_SHOWS&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(HeaderFilmsResponse.self, from: data)
                completion(.success(results.items))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getFullFilm(id: Int ,_ completion: @escaping (Result<FullFilm, Error>) -> Void){
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/\(id)") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let result = try JSONDecoder().decode(FullFilm.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getFilmTrailers(id: Int ,_ completion: @escaping (Result<TrailersResponse, Error>) -> Void){
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/\(id)/videos") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let result = try JSONDecoder().decode(TrailersResponse.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getFilmSimmilars(id: Int ,_ completion: @escaping (Result<SimmilarResponse, Error>) -> Void){
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/\(id)/similars") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let result = try JSONDecoder().decode(SimmilarResponse.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getSearchFilms(query: String ,_ completion: @escaping (Result<[SearchFilm], Error>) -> Void){
        guard let url = URL(string: Constans.URL_FOR_SEARCH.rawValue + "films/search-by-keyword?keyword=\(query)&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let result = try JSONDecoder().decode(SearchFilmResponse.self, from: data)
                completion(.success(result.films))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}

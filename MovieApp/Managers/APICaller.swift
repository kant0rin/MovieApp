//
//  APICaller.swift
//  MovieApp
//
//  Created by Илья Канторин on 28.03.2024.
//

import Foundation

enum Constans: String {
    case API_KEY = "621838e5-4c7b-41b4-836a-8cd6d1518834"
    case BASE_URL = "https://kinopoiskapiunofficial.tech/api/v2.2/"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller(); private init(){}
    
    func getFilms(_ completion: @escaping (Result<[Film], Error>) -> Void){
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
    
    func getFilmDescription(id: Int ,_ completion: @escaping (Result<FilmDescription, Error>) -> Void){
        guard let url = URL(string: Constans.BASE_URL.rawValue + "films/\(id)") else {return}
        
        var request = URLRequest(url: url)
        request.addValue(Constans.API_KEY.rawValue, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {return}
            
            do{
                let result = try JSONDecoder().decode(FilmDescription.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }.resume()
        
    }

}

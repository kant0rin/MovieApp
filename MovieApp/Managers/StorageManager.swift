//
//  SttorageManager.swift
//  MovieApp
//
//  Created by Илья Канторин on 04.04.2024.
//

import UIKit
import CoreData

public final class StorageManager: NSObject {
    static let shared = StorageManager(); private override init(){}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func addFavouriteFilm(_ id: Int, name: String, year: String?, posterUrl: String ) {
        guard let filmEntityDescription = NSEntityDescription.entity(forEntityName: "FavouriteFilm", in: context) else {return}
        let film = FavouriteFilm(entity: filmEntityDescription, insertInto: context)
        film.filmId = Int64(id)
        film.filmYear = year
        film.posterUrl = posterUrl
        film.nameRu = name
        
        appDelegate.saveContext()
        
        print("Saved")
    }
    
    func getFavouritesFilms() -> [FavouriteFilm]? {
        let fetchRequests = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteFilm")
        do {
            return (try? context.fetch(fetchRequests) as? [FavouriteFilm] ?? [])
        }
    }
    
    func isFilmInStorage(_ id: Int64) -> Bool {
        let fetchRequests = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteFilm")
        
        do {
            guard let films = try? context.fetch(fetchRequests) as? [FavouriteFilm] else {return false}
            guard films.first(where: {$0.filmId == id}) != nil else {return false}
            return true
        }
    }
    
    func removeFilm(_ id: Int64) {
        let fetchRequests = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteFilm")
        do {
            guard let films = try? context.fetch(fetchRequests) as? [FavouriteFilm],
                let filmToDelete = films.first(where: {$0.filmId == id}) else {return}
            context.delete(filmToDelete)
        }
        
        appDelegate.saveContext()
    }
}

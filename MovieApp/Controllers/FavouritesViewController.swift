//
//  FavouritesViewController.swift
//  MovieApp
//
//  Created by Илья Канторин on 03.04.2024.
//

import UIKit

final class FavouritesViewController: UIViewController {
    
    private var favouriteFilms: [FavouriteFilm] = []
    
    lazy var backButton = UIBarButtonItem(image: .materialSymbolsLightArrowBackIos.withRenderingMode(.alwaysOriginal),style: .plain, target: self, action: #selector(backToHomeScreen))
    
    private let searchBar = UISearchBar()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavouritesFilmTableViewCell.self, forCellReuseIdentifier: FavouritesFilmTableViewCell.identifier)
        tableView.backgroundColor = Resources.Colors.background
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFavouriteFilms()
        
        setupView()
        setupNavBar()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func backToHomeScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchFavouriteFilms() {
        guard let favFilms =  StorageManager.shared.getFavouritesFilms() else {return}
        self.favouriteFilms = favFilms
        self.tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        headerLabel.text = "Избранное"
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        headerLabel.textAlignment = .center
        tableView.tableHeaderView = headerLabel
    }
    
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        favouriteFilms.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesFilmTableViewCell.identifier, for: indexPath) as? FavouritesFilmTableViewCell else {return UITableViewCell()}
        
        cell.configure(favouriteFilms[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FilmDetailsViewController()
        vc.configure(FilmDetailsViewModel(id: Int(favouriteFilms[indexPath.section].filmId)))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

private extension FavouritesViewController {
    
    func setupView() {
        view.backgroundColor = Resources.Colors.background
        
        [tableView].forEach(view.addSubview)
    }
    
    func setupNavBar() {
        let navApperance = UINavigationBarAppearance()
        navApperance.backgroundColor = Resources.Colors.background
        navigationItem.standardAppearance = navApperance
        
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.endEditing(true)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск в избранном"
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = backButton
    }
}

extension FavouritesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else {return}
        self.favouriteFilms = self.favouriteFilms.filter {
            $0.nameRu!.lowercased().contains(text.lowercased())
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
            fetchFavouriteFilms()
        }
    }
}

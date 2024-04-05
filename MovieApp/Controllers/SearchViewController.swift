//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Илья Канторин on 02.04.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    lazy var backButton = UIBarButtonItem(image: .materialSymbolsLightArrowBackIos.withRenderingMode(.alwaysOriginal),style: .plain, target: self, action: #selector(backToHomeScreen))
    
    private let searchBar = UISearchBar()
    
    private var searchFilms: [SearchFilm] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchFilmTableViewCell.self, forCellReuseIdentifier: SearchFilmTableViewCell.identifier)
        tableView.backgroundColor = Resources.Colors.background
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.background
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setupNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func backToHomeScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNavBar() {
        let navApperance = UINavigationBarAppearance()
        navApperance.backgroundColor = Resources.Colors.background
        navigationItem.standardAppearance = navApperance
        
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.endEditing(true)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск"
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = backButton
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        searchFilms.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchFilmTableViewCell.identifier, for: indexPath) as? SearchFilmTableViewCell else {return UITableViewCell()}
        
        let film = searchFilms[indexPath.section]
        cell.configure(film)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = FilmDetailsViewModel(id: self.searchFilms[indexPath.section].filmId)
        let vc = FilmDetailsViewController()
        vc.configure(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        APICaller.shared.getSearchFilms(query: searchBar.text ?? "") {[weak self] result in
            guard let self else {return}
            switch result {
            case .success(let films): 
                self.searchFilms = films
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error): print(error)
            }
        }
    }
}

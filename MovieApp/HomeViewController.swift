//
//  ViewController.swift
//  MovieApp
//
//  Created by Илья Канторин on 19.03.2024.
//

import UIKit

enum Sections: Int {
    case Popular = 0
    case Premiers = 1
    case Love = 2
    case Series = 3
}

class HomeViewController: UIViewController {
    
    lazy var heartButton = UIBarButtonItem(image: .heart.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(heartButtonClick))
    
    lazy var searchButton = UIBarButtonItem(image: .epSearch.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchButtonClick))
    
    let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    let titles: [String] = ["Популярные", "Премьеры", "Любовь", "Сериалы"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = searchButton
        navigationItem.rightBarButtonItem = heartButton
        
        view.backgroundColor = Resources.Colors.background
        
        let navApperance = UINavigationBarAppearance()
        navApperance.configureWithTransparentBackground()
        navigationItem.standardAppearance = navApperance
        
        setupTableView()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    @objc func searchButtonClick() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func heartButtonClick() {
        let vc = FavouritesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularFilms { result in
                switch result {
                case .success(let films): cell.configure(with: films)
                case .failure(let error): print(error)
                }
            }
        case Sections.Premiers.rawValue:
            APICaller.shared.getPremiers { result in
                switch result {
                case .success(let films): cell.configure(with: films)
                case .failure(let error): print(error)
                }
            }
        case Sections.Love.rawValue:
            APICaller.shared.getLoveFilms { result in
                switch result {
                case .success(let films): cell.configure(with: films)
                case .failure(let error): print(error)
                }
            }
        case Sections.Series.rawValue:
            APICaller.shared.getPopularSerials { result in
                switch result {
                case .success(let films): cell.configure(with: films)
                case .failure(let error): print(error)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame
        
        let title = UILabel()
        title.frame =  CGRectMake(0, 10, headerFrame.size.width-20, 30) //width equals to parent view with 10 left and right margin
        title.font = UIFont.systemFont(ofSize: 20)
        title.text = self.tableView(tableView, titleForHeaderInSection: section) //This will take title of section from 'titleForHeaderInSection' method or you can write directly
        title.textColor = .white
        
        let headerView:UIView = UIView(frame: CGRectMake(0, 0, headerFrame.size.width, headerFrame.size.height))
        headerView.addSubview(title)
        
        return headerView
    }
    
    
    func setupTableView(){
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        
        table.contentInsetAdjustmentBehavior = .never
        
        let tableHeader = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/1.5))
        table.tableHeaderView = tableHeader
        
        tableHeader.scrollView?.viewForTableDelegate = self
        
        APICaller.shared.getFilmsForHeader { result in
            switch result {
            case .success(let films): tableHeader.configureScrollView(with: films)
            case .failure(let error): print(error)
            }
        }
        
        table.backgroundColor = Resources.Colors.background
        
        
    }
    
    
}

extension HomeViewController: CollectionTableViewCellDelegate {
    func collectionTableViewCellDidTap(_ cell: CollectionTableViewCell, viewModel: FilmDetailsViewModel) {
        let vc = FilmDetailsViewController()
        vc.configure(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: ViewForTableHeaderSliderDelegate {
    func viewTapped(id: Int) {
        let vc = FilmDetailsViewController()
        let viewModel = FilmDetailsViewModel(id: id)
        vc.configure(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

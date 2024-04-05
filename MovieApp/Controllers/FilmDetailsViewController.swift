//
//  FilmDetailsViewController.swift
//  MovieApp
//
//  Created by Илья Канторин on 29.03.2024.
//

import UIKit

class FilmDetailsViewController: UIViewController {
    
    lazy var backButton = UIBarButtonItem(image: .materialSymbolsLightArrowBackIos.withRenderingMode(.alwaysOriginal),style: .plain, target: self, action: #selector(backToHomeScreen))
    
    lazy var heartButton = UIBarButtonItem(image: .heart.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(heartButtonClick))
    
    var id: Int!
    
    var filmInfo: [FilmRow] = [.main(FullFilm.moc)]
    var filmTrailer: [FilmRow] = [.trailer(Trailer.moc)]
    var filmSimmilar: [FilmRow] = [.simmilar(SimmilarResponse.moc)]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmDetailsMainCell.self, forCellWithReuseIdentifier: FilmDetailsMainCell.identifier)
        collectionView.register(FilmDetailsTrailerCell.self, forCellWithReuseIdentifier: FilmDetailsTrailerCell.identifier)
        collectionView.register(FilmDetailsSimmilarCell.self, forCellWithReuseIdentifier: FilmDetailsSimmilarCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    
    var dataSource: UICollectionViewDiffableDataSource<FilmSections, FilmRow>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Resources.Colors.background
        
        setupNavBar()
        
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        setupDataSource()
        collectionView.dataSource = self.dataSource
        applyShapshots()
    }
    
    func configure(_ viewModel: FilmDetailsViewModel){
        self.id = viewModel.id
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    @objc func backToHomeScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func heartButtonClick() {
        let vc = FavouritesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupNavBar() {
        let navApperance = UINavigationBarAppearance()
        navApperance.configureWithTransparentBackground()
        navigationItem.standardAppearance = navApperance
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = heartButton
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main( _):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmDetailsMainCell.identifier, for: indexPath) as? FilmDetailsMainCell else {return UICollectionViewCell()}

                APICaller.shared.getFullFilm(id: self.id) { result in
                    switch result {
                    case .success(let film): 
                        DispatchQueue.main.async {
                            let isFilmInStorage = StorageManager.shared.isFilmInStorage(Int64(film.kinopoiskId))
                            cell.configure(film, isFilmInStorage: isFilmInStorage)
                        }
                        
                    case .failure(let error): print(error)
                    }
                }
                
                
                
                return cell
                
            case .trailer(_):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmDetailsTrailerCell.identifier, for: indexPath) as? FilmDetailsTrailerCell else {return UICollectionViewCell()}
                
                APICaller.shared.getFilmTrailers(id: self.id) { result in
                    switch result {
                    case .success(let trailers): cell.configure(trailers.items[0])
                    case .failure(let error): print(error)
                    }
                }
                
                return cell
                
            case .simmilar(_):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmDetailsSimmilarCell.identifier, for: indexPath) as? FilmDetailsSimmilarCell else {return UICollectionViewCell()}
                
                APICaller.shared.getFilmSimmilars(id: self.id) { result in
                    switch result {
                    case .success(let simmilars): 
                        cell.tapDelegate = self
                        cell.configure(simmilars)
                    case .failure(let error): print(error)
                    }
                }
                return cell
            }
            
        
        })
    }
    
    func applyShapshots(){
        var snapshot = NSDiffableDataSourceSnapshot<FilmSections, FilmRow>()
        snapshot.appendSections([.main, .trailer, .simmilar])
        snapshot.appendItems(filmInfo, toSection: .main)
        snapshot.appendItems(filmTrailer, toSection: .trailer)
        snapshot.appendItems(filmSimmilar, toSection: .simmilar)
        dataSource?.apply(snapshot)
    }
    
}

extension FilmDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: view.bounds.width, height: view.bounds.height/1.5)
        case 1:
            return CGSize(width: view.bounds.width, height: 250)
        case 2:
            return CGSize(width: view.bounds.width, height: 300)
        default:
            return CGSize(width: view.bounds.width, height: 500)
        }
    }
}

extension FilmDetailsViewController: FilmDetailsSimmilarCellDelegate {
    func cellDidTap(_ cell: UICollectionViewCell, viewModel: FilmDetailsViewModel) {
        let vc = FilmDetailsViewController()
        vc.configure(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

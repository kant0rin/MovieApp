//
//  CollectionTableViewCell.swift
//  MovieApp
//
//  Created by Илья Канторин on 22.03.2024.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCellDidTap(_ cell: CollectionTableViewCell, viewModel: FilmDetailsViewModel)
}

class CollectionTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionTableViewCell"
    
    weak var delegate: CollectionTableViewCellDelegate?
    
    private var films: [Film] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmForCollectionCell.self, forCellWithReuseIdentifier: FilmForCollectionCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = Resources.Colors.background
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with films: [Film]){
        self.films = films
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            self.collectionView.reloadData()
        }
    }
    
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        films.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmForCollectionCell.identifier, for: indexPath) as? FilmForCollectionCell else { return UICollectionViewCell()}
        
        let film = films[indexPath.row]
        
        cell.configure(with: film)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let filmId = films[indexPath.row].kinopoiskId
        
        let viewModel = FilmDetailsViewModel(id: filmId)
        
        delegate?.collectionTableViewCellDidTap(self, viewModel: viewModel)
    }
    
    
}

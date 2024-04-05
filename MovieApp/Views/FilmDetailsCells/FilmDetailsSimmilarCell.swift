//
//  FilmDetailsSimmilarCell.swift
//  MovieApp
//
//  Created by Илья Канторин on 01.04.2024.
//

import UIKit

protocol FilmDetailsSimmilarCellDelegate: AnyObject {
    func cellDidTap(_ cell: UICollectionViewCell, viewModel: FilmDetailsViewModel)
}

class FilmDetailsSimmilarCell: UICollectionViewCell {
    
    static let identifier = "FilmDetailsSimmilarCell"
    
    var simmilar: [Simmilar] = []
    
    weak var tapDelegate: FilmDetailsSimmilarCellDelegate?
    
    let collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SimmilarFilmCollectionCell.self, forCellWithReuseIdentifier: SimmilarFilmCollectionCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = Resources.Colors.background
        return collection
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Похожие фильмы"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: SimmilarResponse) {
        self.simmilar = model.items
        
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            self.collectionView.reloadData()
        }
    }
    
}

extension FilmDetailsSimmilarCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        simmilar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimmilarFilmCollectionCell.identifier, for: indexPath) as? SimmilarFilmCollectionCell else {return UICollectionViewCell()}
        
        cell.configure(simmilar[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let viewModel = FilmDetailsViewModel(id: simmilar[indexPath.row].filmId)
        tapDelegate?.cellDidTap(self, viewModel: viewModel)
    }
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        contentView.addSubview(collectionView)
        contentView.addSubview(label)
    
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    
}

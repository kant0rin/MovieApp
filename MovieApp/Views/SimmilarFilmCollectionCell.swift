//
//  SimmilarFilmCollectionCell.swift
//  MovieApp
//
//  Created by Илья Канторин on 01.04.2024.
//

import UIKit

class SimmilarFilmCollectionCell: UICollectionViewCell {
    
    static let identifier = "SimmilarFilmCollectionCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var id: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: Simmilar){
        self.id = model.filmId
        guard let url = URL(string: model.posterUrl) else {return}
        self.imageView.sd_setImage(with: url)
    }
    
}

extension SimmilarFilmCollectionCell {
    func setupViews() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

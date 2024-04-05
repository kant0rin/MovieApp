//
//  FavouritesFilmTableViewCell.swift
//  MovieApp
//
//  Created by Илья Канторин on 05.04.2024.
//

import UIKit

final class FavouritesFilmTableViewCell: UITableViewCell {
    
    static let identifier = "FavouritesFilmTableViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let filmName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let filmYear: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: FavouriteFilm){
        guard let url = URL(string: model.posterUrl ?? "") else {return}
        
        self.filmName.text = model.nameRu
        self.filmYear.text = model.filmYear
        self.posterImageView.sd_setImage(with: url)
    }
}

private extension FavouritesFilmTableViewCell {
    func setupViews(){
        contentView.backgroundColor = Resources.Colors.background
        [filmName, posterImageView, filmYear].forEach(contentView.addSubview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 125),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            filmName.topAnchor.constraint(equalTo: contentView.topAnchor),
            filmName.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            filmName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            filmYear.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            filmYear.topAnchor.constraint(equalTo: filmName.bottomAnchor, constant: 20),
        ])
    }
}

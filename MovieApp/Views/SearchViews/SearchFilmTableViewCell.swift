//
//  SearchFilmTableViewCell.swift
//  MovieApp
//
//  Created by Илья Канторин on 02.04.2024.
//

import UIKit

final class SearchFilmTableViewCell: UITableViewCell {
    
    static let identifier = "SearchFilmTableViewCell"
    
    private var filmId: Int!
    
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
    
    private let filmRating: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Resources.Colors.background
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ film: SearchFilm) {
        self.filmId = film.filmId
        self.filmName.text = film.nameRu
        self.filmYear.text = film.year
        self.filmRating.text = film.rating
        
        let str = film.rating
        
        
        
        switch Int(str[str.startIndex..<(str.firstIndex(of: ".") ?? str.endIndex)]) ?? 0 {
        case let rating where rating >= 7:
            self.filmRating.textColor = Resources.Colors.goodFilmRating
        case let rating where rating >= 5 && rating < 7:
            self.filmRating.textColor = Resources.Colors.normalFilmRating
        default:
            self.filmRating.textColor = Resources.Colors.badColorFilmRating
        }
        guard let url = URL(string: film.posterUrl) else {return}
        self.posterImageView.sd_setImage(with: url)
        
    }
    
}

private extension SearchFilmTableViewCell {
    func setupViews(){
        contentView.addSubview(filmRating)
        contentView.addSubview(filmName)
        contentView.addSubview(posterImageView)
        contentView.addSubview(filmYear)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 125),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            filmName.topAnchor.constraint(equalTo: contentView.topAnchor),
            filmName.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            filmName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            filmRating.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            filmRating.topAnchor.constraint(equalTo: filmName.bottomAnchor, constant: 20),
            
            filmYear.leadingAnchor.constraint(equalTo: filmRating.trailingAnchor, constant: 10),
            filmYear.topAnchor.constraint(equalTo: filmName.bottomAnchor, constant: 20),
        ])
    }
}

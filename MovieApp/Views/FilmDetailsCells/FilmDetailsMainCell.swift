//
//  FilmDetailsMainCell.swift
//  MovieApp
//
//  Created by Илья Канторин on 30.03.2024.
//

import UIKit
import SDWebImage

class FilmDetailsMainCell: UICollectionViewCell {
    
    static let identifier = "FilmDetailsMainCell"
    
    private var isFavourite = false
    
    private var infoForDataBase: FullFilm!
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var filmTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        title.textColor = .white
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var filmDescription: UILabel = {
        let desc = UILabel()
        desc.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.textColor = .white
        desc.textAlignment = .left
        desc.numberOfLines = 7
        return desc
    }()
    
    var filmAgeAllowed: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filmDuration: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filmYear: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(likeButtonClick), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let hStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 14
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        addGradientToImageView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configure(_ model: FullFilm, isFilmInStorage: Bool){
        
        guard let imageUrl = URL(string: model.posterUrl) else {return}
        
        self.infoForDataBase = model
        
        self.imageView.sd_setImage(with: imageUrl)
        self.filmTitle.text = model.nameRu
        self.filmDescription.text = model.description.convertToTwoDots()
        self.filmAgeAllowed.text = model.ratingAgeLimits
        self.filmDuration.text = String(model.filmLength) + " минут"
        self.filmYear.text = String(model.year)
        
        
        if isFilmInStorage {
            self.likeButton.setImage(UIImage(named: "heart.fill"), for: .normal)
        }
        self.isFavourite = isFilmInStorage
    }
    
    @objc func likeButtonClick()  {
        
        if !self.isFavourite {
            StorageManager.shared.addFavouriteFilm(
                infoForDataBase.kinopoiskId,
                name: infoForDataBase.nameRu,
                year: String(infoForDataBase.year),
                posterUrl: infoForDataBase.posterUrl
            )
            self.likeButton.setImage(UIImage(named: "heart.fill"), for: .normal)
            self.isFavourite = true
        } else {
            StorageManager.shared.removeFilm(Int64(infoForDataBase.kinopoiskId))
            self.likeButton.setImage(UIImage(named: "heart"), for: .normal)
            self.isFavourite = false
        }
    }
}

extension FilmDetailsMainCell {
    func addGradientToImageView() {
        let view = UIView(frame: imageView.frame)
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, Resources.Colors.background.cgColor]
        gradient.locations = [0,1]
        gradient.frame = self.frame
        view.layer.insertSublayer(gradient, at: 1)
        
        imageView.addSubview(view)
        imageView.bringSubviewToFront(view)
    }
    
    func setupViews(){
        [filmDuration, filmAgeAllowed, filmYear].forEach(hStack.addArrangedSubview)
        [imageView, hStack, filmTitle, filmDescription, likeButton].forEach(contentView.addSubview)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            filmTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filmTitle.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -100),
            filmTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            hStack.topAnchor.constraint(equalTo: filmTitle.bottomAnchor, constant: 5),
            hStack.leadingAnchor.constraint(equalTo: filmTitle.leadingAnchor),
            
            likeButton.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 5),
            likeButton.leadingAnchor.constraint(equalTo: filmTitle.leadingAnchor),
            
            filmDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            filmDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filmDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            filmDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
}

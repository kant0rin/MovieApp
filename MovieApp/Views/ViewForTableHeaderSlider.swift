//
//  ViewForTableHeaderSlider.swift
//  MovieApp
//
//  Created by Илья Канторин on 24.03.2024.
//

import UIKit

protocol ViewForTableHeaderSliderDelegate: AnyObject {
    func viewTapped(id: Int)
}

class ViewForTableHeaderSlider: UIView {
    
    let imageView = UIImageView()
    let filmTitleLabel = UILabel()
    let filmDescriptionLabel = UILabel()
    let filmId: Int
    
    weak var delegate: ViewForTableHeaderSliderDelegate?
    
    required init(imageUrl: String, filmTitle: String, filmDescription: String, filmId: Int, frame: CGRect) {
        self.imageView.sd_setImage(with: URL(string: imageUrl)!)
        self.filmTitleLabel.text = filmTitle
        self.filmDescriptionLabel.text = filmDescription
        self.filmId = filmId
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        addGestureRecognizer(singleTap)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func tapDetected() {
        delegate?.viewTapped(id: filmId)
    }
    
    
}

extension ViewForTableHeaderSlider {
    
    func setupView(){
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = bounds
        addSubview(imageView)
        
        //MARK: - Create and add Title
        filmTitleLabel.font = UIFont.systemFont(ofSize: 30, weight: .black)
        filmTitleLabel.textAlignment = .center
        filmTitleLabel.numberOfLines = 3
        filmTitleLabel.textColor = .white
        filmTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(filmTitleLabel)
        
        //MARK: - Create and add description
        
        filmDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        filmDescriptionLabel.textAlignment = .center
        filmDescriptionLabel.numberOfLines = 3
        filmDescriptionLabel.textColor = .white
        filmDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(filmDescriptionLabel)
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, Resources.Colors.background.cgColor]
        gradient.locations = [0,1]
        gradient.frame = bounds
        
        layer.insertSublayer(gradient, at: 1)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            filmTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 1.8),
            filmTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            filmTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filmDescriptionLabel.topAnchor.constraint(equalTo: filmTitleLabel.bottomAnchor, constant: 30),
            filmDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            filmDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])
    }
}

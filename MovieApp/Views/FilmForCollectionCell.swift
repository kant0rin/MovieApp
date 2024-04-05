//
//  FilmForCollectionCell.swift
//  MovieApp
//
//  Created by Илья Канторин on 29.03.2024.
//

import UIKit
import SDWebImage

class FilmForCollectionCell: UICollectionViewCell {
    
    static let identifier = "FilmCollectionCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = contentView.bounds
    }
    
    public func configure(with model: Film){
        guard let url = URL(string: model.posterUrl) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching image data: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to create UIImage from data")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
            }
        }
        task.resume()

        
    }
    
}

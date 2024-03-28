//
//  TableViewHeader.swift
//  MovieApp
//
//  Created by Илья Канторин on 23.03.2024.
//

import UIKit
import SDWebImage

class TableHeaderScrollView: UIScrollView {
    
    var films: [Film] = []
    
    init(dribblingDelegate: UIScrollViewDelegate, frame: CGRect) {
        super.init(frame: frame)
        
        delegate = dribblingDelegate
        isPagingEnabled = true
        contentSize = CGSize(width: frame.width * 3, height: frame.height)
        showsHorizontalScrollIndicator = false
        
        var imageViewRect = CGRect(origin: .zero, size: CGSize(width: frame.width, height: frame.height))
        let vikings = ViewForTableHeaderSlider(image: UIImage(named: "vikings")!, filmTitle: "Викинги", filmDescription: "Lorem ipsum dolor sit amet consectetur. Eget dictum est penatibus eget nunc. Enim pellentesque venenatis enim.", filmId: 5567, frame: imageViewRect)
        addSubview(vikings)
        
        imageViewRect.origin.x += imageViewRect.size.width
        let breakingBad = ViewForTableHeaderSlider(image: UIImage(named: "breakingbad")!, filmTitle: "Во все тяжкие", filmDescription: "Lorem ipsum dolor sit amet consectetur. Eget dictum est penatibus eget nunc. Enim pellentesque venenatis enim.", filmId: 4532, frame: imageViewRect)
        addSubview(breakingBad)
        
        imageViewRect.origin.x += imageViewRect.size.width
        let queen = ViewForTableHeaderSlider(image: UIImage(named: "queen")!, filmTitle: "Ход королевы", filmDescription: "Lorem ipsum dolor sit amet consectetur. Eget dictum est penatibus eget nunc. Enim pellentesque venenatis enim.", filmId: 3231, frame: imageViewRect)
        addSubview(queen)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: [Film]) {
        self.films = model
    }
    
}


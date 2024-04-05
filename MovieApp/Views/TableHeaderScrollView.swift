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
    
    weak var viewForTableDelegate: ViewForTableHeaderSliderDelegate?
    
    init(dribblingDelegate: UIScrollViewDelegate, frame: CGRect) {
        super.init(frame: frame)
        
        delegate = dribblingDelegate
        isPagingEnabled = true
        contentSize = CGSize(width: frame.width * 6, height: frame.height)
        showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: [Film]) {
        self.films = model
        
        DispatchQueue.main.async {[weak self] in
            guard let self else {return}
            
            var imageViewRect = CGRect(origin: .zero, size: CGSize(width: frame.width, height: frame.height))
    
            self.films[0...5].enumerated().forEach {
                
                let view = ViewForTableHeaderSlider(
                    imageUrl: $0.element.posterUrl,
                    filmTitle: $0.element.nameRu,
                    filmDescription: "",
                    filmId: $0.element.kinopoiskId,
                    frame: imageViewRect)
                
                view.delegate = self.viewForTableDelegate
           
                self.addSubview(view)
                
                imageViewRect.origin.x += imageViewRect.size.width
                
            }
            
        }
    }
    
    
}


//
//  FilmDetailsTrailerCell.swift
//  MovieApp
//
//  Created by Илья Канторин on 30.03.2024.
//

import UIKit
import WebKit

class FilmDetailsTrailerCell: UICollectionViewCell {
    
    static var identifier = "FilmDetailsTrailerCell"
    
    let webView: WKWebView = {
        let wvConfig = WKWebViewConfiguration()
        wvConfig.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: wvConfig)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Трейлер"
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
    
    func configure(_ model: Trailer) {
        guard let url = URL(string: model.url) else {return}
        DispatchQueue.global().async {
            let request = URLRequest(url: url)
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.webView.load(request)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilmDetailsTrailerCell: WKUIDelegate{
    
    func setupViews(){
        contentView.addSubview(webView)
        webView.uiDelegate = self
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            webView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
}

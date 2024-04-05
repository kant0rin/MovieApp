//
//  TableHeaderView.swift
//  MovieApp
//
//  Created by Илья Канторин on 26.03.2024.
//

import UIKit

class TableHeaderView: UIView {
    
    var scrollView: TableHeaderScrollView?
    let pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        scrollView = TableHeaderScrollView(dribblingDelegate: self, frame: frame)
        
        setupViews()
        setupConstrains()
    }
    
    
    public func configureScrollView(with films:[Film]){
        scrollView?.configure(with: films)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableHeaderView: UIScrollViewDelegate {
    
    
    func setupViews(){
        
        addSubview(scrollView ?? UIView(frame: frame))
        
        pageControl.numberOfPages = 6
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(pageControl)
    }
    
    func setupConstrains(){
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: bottomAnchor, constant: -50),
        ])
    }
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            if let pageOffset = ScrollPageController().pageOffset(
                for: scrollView.contentOffset.x,
                velocity: velocity.x,
                in: pageOffsets(in: scrollView)
            ) {
                targetContentOffset.pointee.x = pageOffset
            }
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if let pageFraction = ScrollPageController().pageFraction(
                for: scrollView.contentOffset.x,
                in: pageOffsets(in: scrollView)
            ) {
                let pageControl: UIPageControl = pageControl
                pageControl.currentPage = Int(round(pageFraction))
            }
        }
    
    private func pageOffsets(in scrollView: UIScrollView) -> [CGFloat] {
            let pageWidth = scrollView.bounds.width
                            - scrollView.adjustedContentInset.left
                            - scrollView.adjustedContentInset.right
            let numberOfPages = Int(ceil(scrollView.contentSize.width / pageWidth))
            return (0..<numberOfPages).map { CGFloat($0) * pageWidth - scrollView.adjustedContentInset.left }
        }

}

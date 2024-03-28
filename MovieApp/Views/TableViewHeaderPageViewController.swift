//
//  TableViewHeaderPageViewController.swift
//  MovieApp
//
//  Created by Илья Канторин on 26.03.2024.
//

import UIKit

class TableViewHeaderPageViewController: UIPageViewController {
    
    var titles = ["Privet", "xuy", "jopa", "aaaa", "govno"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    lazy var viewControllersArray: [ViewControllerForHeaderSlider] = {
        var arr = [ViewControllerForHeaderSlider]()
        for title in titles {arr.append(ViewControllerForHeaderSlider(text: title))}
        return arr
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        setViewControllers([viewControllersArray[0]], direction: .forward, animated: true)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewHeaderPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? ViewControllerForHeaderSlider else {return nil}
        if let index = viewControllersArray.firstIndex(of: vc) {
            if index > 0 {
                viewControllersArray[index - 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? ViewControllerForHeaderSlider else {return nil}
        if let index = viewControllersArray.firstIndex(of: vc) {
            if index < titles.count - 1 {
                viewControllersArray[index + 1]
            }
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        titles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
}

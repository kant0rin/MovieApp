//
//  ViewController.swift
//  MovieApp
//
//  Created by Илья Канторин on 19.03.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    let listButton = UIBarButtonItem(image: .phList.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
    
    let searchButton = UIBarButtonItem(image: .epSearch.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
    
    let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    let titles: [String] = ["Популярные", "Премьеры", "Любовь", "Сериалы", "Жанры"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = listButton
        navigationItem.rightBarButtonItem = searchButton
        
        view.backgroundColor = Resources.Colors.background
        
        let navApperance = UINavigationBarAppearance()
        navApperance.configureWithTransparentBackground()
        navigationItem.standardAppearance = navApperance
        
        setupTableView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame

            let title = UILabel()
            title.frame =  CGRectMake(0, 10, headerFrame.size.width-20, 30) //width equals to parent view with 10 left and right margin
        title.font = UIFont.systemFont(ofSize: 20)
            title.text = self.tableView(tableView, titleForHeaderInSection: section) //This will take title of section from 'titleForHeaderInSection' method or you can write directly
        title.textColor = .white

            let headerView:UIView = UIView(frame: CGRectMake(0, 0, headerFrame.size.width, headerFrame.size.height))
            headerView.addSubview(title)

            return headerView
    }

    
    func setupTableView(){
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        
        table.contentInsetAdjustmentBehavior = .never
            
        let tableHeader = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/1.5))
        
        table.tableHeaderView = tableHeader
        table.backgroundColor = Resources.Colors.background
        
        
    }
    
    
}

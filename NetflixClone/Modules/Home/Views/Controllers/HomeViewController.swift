//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/04/23.
//

import UIKit

enum TableSections: Int {
    case genres = 0
    case movies = 1
}

class HomeViewController: UIViewController {
    
    var sections = ["Genres", "Popular"]
    var genres = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family"]
    
    private lazy var homeTable: UITableView = {
        let movieTable = UITableView(frame: .zero, style: .grouped)
        movieTable.translatesAutoresizingMaskIntoConstraints = false
        movieTable.register(SectionCellHeader.self, forHeaderFooterViewReuseIdentifier: SectionCellHeader.identifier)
        movieTable.register(UINib(nibName: "MainTableCell", bundle: nil), forCellReuseIdentifier: MainTableCell.identifier)
        movieTable.register(GenresTableCell.self, forCellReuseIdentifier: GenresTableCell.identifier)
        return movieTable
    }()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTable()
        setupTableHeader()

    }
    
    private func setupNavigationBar() {
//        navigationController?.navigationBar.setGradientBackground(colors: [.black, .clear], locations: [0,1])
        navigationController?.hidesBarsOnSwipe = true
        
        let leftNavigationBarItems = LeftNavBarItems()
        leftNavigationBarItems.setupLeftNavBarItems()
        
        let rightNavigationBarItems = RightNavBarItems()
        rightNavigationBarItems.setupBarItem()
        
        navigationItem.setLeftBarButton(leftNavigationBarItems, animated: true)
        navigationItem.setRightBarButton(rightNavigationBarItems, animated: true)
    }
    
    private func setupTable() {
        view.addSubview(homeTable)
        
        homeTable.backgroundColor = .systemBackground
//        homeTable.separatorStyle = .none
        homeTable.tableFooterView = UIView(frame: CGRect.zero)
        homeTable.sectionFooterHeight = 0.0
        
        NSLayoutConstraint.activate([
            homeTable.topAnchor.constraint(equalTo: view.topAnchor),
            homeTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        self.homeTable.delegate = self
        self.homeTable.dataSource = self

    }
    
    private func setupTableHeader() {
        homeTable.tableHeaderView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
    }
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = homeTable.dequeueReusableHeaderFooterView(withIdentifier: SectionCellHeader.identifier) as? SectionCellHeader
        header?.addSubviews()
        header?.configure(title: sections[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = TableSections(rawValue: indexPath.section)
        
        switch section {
        case .genres:
            guard let genre = homeTable.dequeueReusableCell(withIdentifier: GenresTableCell.identifier, for: indexPath) as? GenresTableCell else { return UITableViewCell() }
            genre.setupCollectionView()
            return genre
        case .movies:
            guard let cell = homeTable.dequeueReusableCell(withIdentifier: MainTableCell.identifier, for: indexPath) as? MainTableCell else { return UITableViewCell() }
            cell.setupCollectionView()
            return cell
        default:
            return UITableViewCell()
        }
    
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let defaultOffset = view.safeAreaInsets.top
//        let offset = scrollView.contentOffset.y + defaultOffset
//
//        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
//    }
    
}

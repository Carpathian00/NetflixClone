//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/04/23.
//

import UIKit

protocol HomeViewControllerDelegate {
    func moveToDetailPage(model: Item?)
}

enum TableSections: Int {
    case genres = 0
    case movies = 1
}

class HomeViewController: UIViewController {
    
    private let homeVM = HomeViewModel()
    private var items: [Item]?
    private var headerMovie: HeroHeaderView?
    
    var sections = ["Genres", "Popular", "TV Shows", "Action"]
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
        callApi()
    }
    
    private func setupNavigationBar() {
//        navigationController?.hidesBarsOnSwipe = true
        
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
        homeTable.separatorStyle = .none
        homeTable.tableFooterView = UIView(frame: CGRect.zero)
        homeTable.sectionFooterHeight = 0.0
        
        NSLayoutConstraint.activate([
            homeTable.topAnchor.constraint(equalTo: view.topAnchor),
            homeTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        homeTable.delegate = self
        homeTable.dataSource = self

    }
    
    private func setupTableHeader() {
        self.headerMovie = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))

        homeTable.tableHeaderView = self.headerMovie
    }
    
    private func callApi() {
        self.homeVM.fetchPopularMoviesData()
        self.homeVM.bindItemData = { movieModel in
            if let model = movieModel {
                let selectedTitle = model.randomElement()
                guard let selectedTitle = selectedTitle else { return }
                self.headerMovie?.configure(with: selectedTitle)
                
                self.items = model
            }
            DispatchQueue.main.async {
                self.homeTable.reloadData()
            }
        }
    }
    
        
}

extension HomeViewController: HomeViewControllerDelegate {
    func moveToDetailPage(model: Item?) {
        let vc = MovieDetailViewController()
        vc.item = model
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationController?.isNavigationBarHidden = false
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
            cell.configure(modelData: items)
            cell.homeVCDelegate = self
            return cell
        default:
            return UITableViewCell()
        }
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
           if offsetY > 50 {
               navigationController?.setNavigationBarHidden(true, animated: true)
           } else {
               navigationController?.setNavigationBarHidden(false, animated: true)
           }
    }

    
}

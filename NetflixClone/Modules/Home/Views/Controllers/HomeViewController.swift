//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/04/23.
//

import UIKit

protocol HomeViewControllerDelegate {
    func moveToDetailPage(model: Item?, fromTableHeader: Bool)
    func moveToViewAllPage(section: Int)
}

enum TableSections: Int {
    case genres = 0
    case movies = 1
}

class HomeViewController: UIViewController {
    
    private let homeVM = HomeViewModel()
    private var items: [Item]?
    private var genres: [Genre]?
    private var headerMovie: HeroHeaderView?
    
    var sections = ["Genres", "Popular", "TV Shows", "Action"]
//    var genres = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family"]
//
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
        headerMovie?.homeVCDelegate = self
    }
    
    private func callApi() {
        self.homeVM.fetchPopularMoviesData(currentPage: 1)
        self.homeVM.bindItemData = { movieModel in
            if let model = movieModel {
                let selectedTitle = model.randomElement()
                guard let selectedTitle = selectedTitle else { return }
                self.headerMovie?.configure(with: selectedTitle)
                
                self.items = model
                DispatchQueue.main.async { [weak self] in
                    if self?.items != nil {
                        self?.homeTable.reloadData()
                    }
                }
            }
            
        }
        
        self.homeVM.fetchGenresData()
        self.homeVM.bindGenreData = { genreModel in
            if let model = genreModel {
                self.genres = model
                DispatchQueue.main.async { [weak self] in
                    if self?.genres != nil {
                        self?.homeTable.reloadData()
                    }
                }
            }
        }
        
        print("data home page: \(self.items)")
    }
    
        
}

extension HomeViewController: HomeViewControllerDelegate {
    func moveToDetailPage(model: Item?, fromTableHeader: Bool) {
        let vc = MovieDetailViewController()
        vc.configure(model: model)
        
        if fromTableHeader == true {
            self.navigationController?.present(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

    func moveToViewAllPage(section: Int) {
        let vc = ViewAllViewController()
        vc.configure(section: section)
        vc.homeVCDelegate = self
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
        header?.configure(title: sections[section], index: section)
        header?.homeVCDelegate = self

        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = TableSections(rawValue: indexPath.section)
        
        switch section {
        case .genres:
            guard let genre = homeTable.dequeueReusableCell(withIdentifier: GenresTableCell.identifier, for: indexPath) as? GenresTableCell else { return UITableViewCell() }
            genre.setupCollectionView()
            genre.configure(genreModel: genres)
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
}

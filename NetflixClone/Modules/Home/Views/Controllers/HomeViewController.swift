//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/04/23.
//

import UIKit
import RxSwift

enum TableSections: Int {
    case genres = 0
    case popularMovies = 1
    case popularTvShows = 2
    case topRatedMovies = 3
    case topRatedTvShows = 4
    case other = 5
}

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let homeVM = HomeViewModel()
    private var popularMovies: [ItemData]?
    private var popularTvShows: [ItemData]?
    private var TopRatedMovies: [ItemData]?
    private var topRatedTvShows: [ItemData]?
    private var genres: [Genre]?
    private var headerMovie: HeroHeaderView?
    var tabBarDelegate: TabBarControllerDelegate?
    var sections = ["Genres", "Popular Movies", "Popular TV Shows", "Top Rated Movies", "Top Rated TV Shows"]
    let refreshControl = UIRefreshControl()

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
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTable()
        setupTableHeader()
        bindVM()
        callApi()
    }
    
    private func setupNavigationBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let leftNavigationBarItems = LeftNavBarItems()
        leftNavigationBarItems.setupLeftNavBarItems()
        
        let rightNavigationBarItems = RightNavBarItems()
        rightNavigationBarItems.setupBarItem()
        
        navigationItem.setLeftBarButton(leftNavigationBarItems, animated: true)
        navigationItem.setRightBarButton(rightNavigationBarItems, animated: true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
           return true
       }
    
    private func setupTable() {
        homeTable.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

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
    
    @objc func refreshData() {
        callApi()
        refreshControl.endRefreshing()
    }
    
    private func setupTableHeader() {
        self.headerMovie = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))

        homeTable.tableHeaderView = self.headerMovie
        headerMovie?.homeVCDelegate = self.tabBarDelegate
        headerMovie?.navigationController = self.navigationController
    }
    
    private func callApi() {
        self.homeVM.getPopularMoviesData(currentPage: 1)
        self.homeVM.getGenresData()
        self.homeVM.getPopularTvShowsData(currentPage: 1)
        self.homeVM.getTopRatedMoviesData(currentPage: 1)
        self.homeVM.getTopRatedTvShowsData(currentPage: 1)
    }
    
    private func bindVM() {
        self.homeVM.onReloadSection.subscribe { [weak self] section in
            guard let `self` = self else { return }
            
            let indexes = IndexSet(integer: section.rawValue)
            
            DispatchQueue.main.async {
                self.homeTable.reloadSections(indexes, with: .automatic)
            }
        }.disposed(by: disposeBag)
        
        self.homeVM.onSetHeader.subscribe { selectedTitle in
            self.headerMovie?.configure(with: selectedTitle)

        }.disposed(by: disposeBag)
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
        let sections = TableSections(rawValue: indexPath.section)
        
        switch sections {
        case .genres:
            return 150
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = homeTable.dequeueReusableHeaderFooterView(withIdentifier: SectionCellHeader.identifier) as? SectionCellHeader
        header?.addSubviews()
        header?.configure(title: sections[section], index: section)
        header?.homeVCDelegate = self.tabBarDelegate
        header?.navigationController = self.navigationController

        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sections = TableSections(rawValue: indexPath.section)
        
        switch sections {
        case .genres:
            guard let genre = homeTable.dequeueReusableCell(withIdentifier: GenresTableCell.identifier, for: indexPath) as? GenresTableCell else { return UITableViewCell() }
            genre.setupCollectionView()
            genre.configure(genreModel: homeVM.genreData)
            genre.homeVCDelegate = self.tabBarDelegate
            genre.navigationController = self.navigationController
            return genre
            
        case .popularMovies:
            guard let cell = homeTable.dequeueReusableCell(withIdentifier: MainTableCell.identifier, for: indexPath) as? MainTableCell else { return UITableViewCell() }
            cell.setupCollectionView()
            cell.configure(modelData: homeVM.popularMoviesData, isTopRated: false)
            cell.homeVCDelegate = self.tabBarDelegate
            cell.navigationController = self.navigationController
            return cell
            
        case .popularTvShows:
            guard let cell = homeTable.dequeueReusableCell(withIdentifier: MainTableCell.identifier, for: indexPath) as? MainTableCell else { return UITableViewCell() }
            cell.setupCollectionView()
            cell.configure(modelData: homeVM.popularTvShowsData, isTopRated: false)
            cell.homeVCDelegate = self.tabBarDelegate
            cell.navigationController = self.navigationController
            return cell
            
        case .topRatedMovies:
            guard let cell = homeTable.dequeueReusableCell(withIdentifier: MainTableCell.identifier, for: indexPath) as? MainTableCell else { return UITableViewCell() }
            cell.setupCollectionView()
            cell.configure(modelData: homeVM.topRatedMoviesData, isTopRated: true)
            cell.homeVCDelegate = self.tabBarDelegate
            cell.navigationController = self.navigationController
            return cell
            
        case .topRatedTvShows:
            guard let cell = homeTable.dequeueReusableCell(withIdentifier: MainTableCell.identifier, for: indexPath) as? MainTableCell else { return UITableViewCell() }
            cell.setupCollectionView()
            cell.configure(modelData: homeVM.topRatedTvShowsData, isTopRated: true)
            cell.homeVCDelegate = self.tabBarDelegate
            cell.navigationController = self.navigationController
            return cell

        default:
            return getBlankCell()
        }
    }
    
    private func getBlankCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        return cell
    }
}

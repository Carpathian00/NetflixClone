//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

enum searchTableSections: Int {
    case trendingMovies = 0
    case trendingTVs = 1
}

enum SearchRequestType: String {
    case movie = "movie"
    case tv = "tv"
}

class SearchViewController: UIViewController {

    private var searchVM = SearchViewModel()
    private var trendingMovies: [ItemData]?
    private var trendingTVs: [ItemData]?
    var tabBarDelegate: TabBarControllerDelegate?
    
    private lazy var searchTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UINib(nibName: "SearchTableCell", bundle: nil), forCellReuseIdentifier: SearchTableCell.identifier)
        table.register(SectionCellHeader.self, forHeaderFooterViewReuseIdentifier: SectionCellHeader.identifier)
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.setCenteredPlaceholder()
        controller.searchBar.tintColor = .label
        return controller
    }()
    
    let sections = ["Trending Movie Searches", "Trending TV Shows Searches "]
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTable()
        callApi()
    }

    private func setupNavbar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchBar.delegate = self

    }
    
    private func setupTable() {
        view.addSubview(searchTable)
        searchTable.frame = view.bounds
        searchTable.backgroundColor = .systemBackground
        searchTable.separatorStyle = .none
        searchTable.tableFooterView = UIView(frame: CGRect.zero)
        searchTable.sectionFooterHeight = 0.0
        
        NSLayoutConstraint.activate([
            searchTable.topAnchor.constraint(equalTo: view.topAnchor),
            searchTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        searchTable.delegate = self
        searchTable.dataSource = self
        searchController.searchResultsUpdater = self
    }
    
    private func callApi() {
        trendingMoviesApi()
        trendingTVsApi()
    }
    
    private func trendingMoviesApi() {
        self.searchVM.fetchTrendingMoviesData()
        self.searchVM.bindTrendingMoviesData = { trendingMoviesResult in
            self.trendingMovies = trendingMoviesResult

            DispatchQueue.main.async {
                self.searchTable.reloadData()
            }
        }
    }
    
    private func trendingTVsApi() {
        self.searchVM.fetchTrendingTvsData()
        self.searchVM.bindTrendingTVsData = { trendingTVsResult in
            self.trendingTVs = trendingTVsResult
            DispatchQueue.main.async {
                self.searchTable.reloadData()
            }
        }
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = searchTable.dequeueReusableHeaderFooterView(withIdentifier: SectionCellHeader.identifier) as? SectionCellHeader
        header?.addSubviews()
        header?.configure(title: sections[section], index: 0)
        return header
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = searchTableSections(rawValue: indexPath.section)

        switch sections {
            
        case .trendingMovies:
            guard let moviesCell = searchTable.dequeueReusableCell(withIdentifier: SearchTableCell.identifier, for: indexPath) as? SearchTableCell else { return UITableViewCell() }
            moviesCell.configure(itemModel: self.trendingMovies?[indexPath.row])
            return moviesCell

        case .trendingTVs:
            guard let tvsCell = searchTable.dequeueReusableCell(withIdentifier: SearchTableCell.identifier, for: indexPath) as? SearchTableCell else { return UITableViewCell() }
            tvsCell.configure(itemModel: self.trendingTVs?[indexPath.row])
            return tvsCell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = self.navigationController else { return }
        let sections = searchTableSections(rawValue: indexPath.section)
        
        switch sections {
        case .trendingMovies:
            self.tabBarDelegate?.moveToDetailPage(model: self.trendingMovies?[indexPath.row], fromTableHeader: false, isPlayOnly: false, navCon: navigationController)
        case .trendingTVs:
            self.tabBarDelegate?.moveToDetailPage(model: self.trendingTVs?[indexPath.row], fromTableHeader: false, isPlayOnly: false, navCon: navigationController)
        default:
            print("error")
        }
        

    }
    
}

extension SearchViewController: UISearchResultsUpdating, SearchResultVCDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
         
        resultController.delegate = self
        
        searchVM.fetchSearchData(query: query, type: SearchRequestType.movie.rawValue)
        searchVM.bindMovieSearchResultData = { result in
            DispatchQueue.main.async {
                if result != nil {
                    resultController.movieResults = result
                    resultController.searchResultsCollectionView.reloadData()
                }
            }
        }
        
        searchVM.fetchSearchData(query: query, type: SearchRequestType.tv.rawValue)
        searchVM.bindTvShowsSearchResultData = { result in
            DispatchQueue.main.async {
                if result != nil {
                    resultController.tvShowResults = result
                    resultController.searchResultsCollectionView.reloadData()
                }
            }
        }
        
    }
    
    func didTapSearchResultCell(itemModel: ItemData?) {
        guard let navCon = self.navigationController else { return }
        self.tabBarDelegate?.moveToDetailPage(model: itemModel, fromTableHeader: false, isPlayOnly: false, navCon: navCon)
    }
    


}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setPositionAdjustment(UIOffset.zero, for: .search)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setCenteredPlaceholder()
        return true
    }
}

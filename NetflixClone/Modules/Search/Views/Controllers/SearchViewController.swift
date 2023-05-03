//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

class SearchViewController: UIViewController {

    private lazy var searchTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UINib(nibName: "SearchTableCell", bundle: nil), forCellReuseIdentifier: SearchTableCell.identifier)
        table.register(SectionCellHeader.self, forHeaderFooterViewReuseIdentifier: SectionCellHeader.identifier)
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Search"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.setCenteredPlaceholder()
        controller.searchBar.tintColor = .label
        return controller
    }()
    
    let sections = ["Top movie searches", "Trending TV Shows"]
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTable()
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
        return 90
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = searchTable.dequeueReusableHeaderFooterView(withIdentifier: SectionCellHeader.identifier) as? SectionCellHeader
        header?.addSubviews()
        header?.configure(title: sections[section], index: 0)
        return header
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTable.dequeueReusableCell(withIdentifier: SearchTableCell.identifier, for: indexPath) as? SearchTableCell else { return UITableViewCell() }
        return cell
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

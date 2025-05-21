//
//  ViewAllViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 25/04/23.
//

import UIKit

class ViewAllViewController: UIViewController {
    
    var selectedSection: Int?
    var homeVCDelegate: TabBarControllerDelegate?
    private var viewAllVM: ViewAllViewModel?
    private var items = [ItemData]()
    private var currentPage = 1
    
    private lazy var viewAllTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "ViewAllMoviesTableCell", bundle: nil), forCellReuseIdentifier: ViewAllMoviesTableCell.identifier)
        return table
    }()
    
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTable()
        setupData()
    }
    
    private func setupNavBar() {
        print("selected section: \(self.selectedSection ?? 0)")
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if selectedSection == TableSections.popularMovies.rawValue {
            title = "Popular Movies"
        } else if selectedSection == TableSections.popularTvShows.rawValue {
            title = "Popular TV Shows"
        } else if selectedSection == TableSections.topRatedMovies.rawValue {
            title = "Top Rated Movies"
        } else if selectedSection == TableSections.topRatedTvShows.rawValue {
            title = "Top Rated TV Shows"
        }
    }
    
    private func setupTable() {
        view.addSubview(viewAllTable)
        
        viewAllTable.backgroundColor = .systemBackground
        viewAllTable.separatorStyle = .none
        viewAllTable.tableFooterView = UIView(frame: CGRect.zero)
        viewAllTable.sectionFooterHeight = 0.0
        
        NSLayoutConstraint.activate([
            viewAllTable.topAnchor.constraint(equalTo: view.topAnchor),
            viewAllTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewAllTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewAllTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewAllTable.delegate = self
        viewAllTable.dataSource = self
        
    }
    
    private func setupData() {
        guard let selectedSection = self.selectedSection else { return }
        self.viewAllVM = ViewAllViewModel(selectedSection: selectedSection)
        self.viewAllVM?.getData(currentPage: 1)
        
        self.viewAllVM?.bindItemData = { result in
            
            guard let resultItems = result else { return }
            self.items.append(contentsOf: resultItems)
            DispatchQueue.main.async {
                
                self.viewAllTable.reloadData()
            }
        }
    }
    
    func configure(section: Int) {
        self.selectedSection = section
    }
}

extension ViewAllViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewAllTable.dequeueReusableCell(withIdentifier: ViewAllMoviesTableCell.identifier, for: indexPath) as? ViewAllMoviesTableCell else { return UITableViewCell() }
        cell.configure(itemModel: self.items[indexPath.row], section: self.selectedSection, index: indexPath.row + 1)
        return cell
    }
    
    func createSpinnerView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewAllTable.tableFooterView = self.createSpinnerView()
        
        let lastIndex = self.items.count-1
        if indexPath.row == lastIndex {
            currentPage += 1
            self.viewAllVM?.getData(currentPage: self.currentPage)
            self.viewAllVM?.bindItemData = { result in
                guard let resultItems = result else { return }
                self.items.append(contentsOf: resultItems)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.viewAllTable.reloadData()
                    self.viewAllTable.tableFooterView = nil
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = self.navigationController else { return }
        self.homeVCDelegate?.moveToDetailPage(model: self.items[indexPath.row], fromTableHeader: false, isPlayOnly: false, navCon: navigationController)
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ViewAllMoviesTableCell {
            cell.cancelImageLoad()
        }
    }
}

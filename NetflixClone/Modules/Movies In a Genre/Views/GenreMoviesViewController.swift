//
//  GenreMoviesViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 02/05/23.
//

import UIKit

class GenreMoviesViewController: UIViewController {

    private var genreMoviesVM = GenreMoviesViewModel()
    private var genre: Genre?
    private var items = [Item]()
    private var currentPage = 1
    var homeVCDelegate: TabBarControllerDelegate?

    

    
    private lazy var genreMoviesTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "ViewAllMoviesTableCell", bundle: nil), forCellReuseIdentifier: ViewAllMoviesTableCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTable()
        callApi()
    }

    private func setupNavBar() {
        title = self.genre?.name
        self.navigationController?.navigationBar.tintColor = .label
    }

    
    private func setupTable() {
        view.addSubview(genreMoviesTable)
        
        genreMoviesTable.backgroundColor = .systemBackground
        genreMoviesTable.separatorStyle = .none
        genreMoviesTable.tableFooterView = UIView(frame: CGRect.zero)
        genreMoviesTable.sectionFooterHeight = 0.0
        
        NSLayoutConstraint.activate([
            genreMoviesTable.topAnchor.constraint(equalTo: view.topAnchor),
            genreMoviesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genreMoviesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genreMoviesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        genreMoviesTable.delegate = self
        genreMoviesTable.dataSource = self
    }

    private func callApi() {
        self.genreMoviesVM.fetchMoviesByTheGenre(genreId: genre?.id ?? 0, currentPage: 1)
        self.genreMoviesVM.bindMoviesData = { [weak self] result in
            guard let result = result else { return }
            self?.items.append(contentsOf: result)
            DispatchQueue.main.async {
                self?.genreMoviesTable.reloadData()
            }
        }
    }
    
    func configure(genre: Genre?) {
        self.genre = genre
    }
}

extension GenreMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = genreMoviesTable.dequeueReusableCell(withIdentifier: ViewAllMoviesTableCell.identifier, for: indexPath) as? ViewAllMoviesTableCell else { return UITableViewCell() }
        cell.configure(itemModel: items[indexPath.row])
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
        self.genreMoviesTable.tableFooterView = self.createSpinnerView()

        let lastIndex = self.items.count-1
        if indexPath.row == lastIndex {
            currentPage += 1
            self.genreMoviesVM.fetchMoviesByTheGenre(genreId: self.genre?.id ?? 0, currentPage: self.currentPage)
            self.genreMoviesVM.bindMoviesData = { result in
                guard let resultItems = result else { return }
                self.items.append(contentsOf: resultItems)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.genreMoviesTable.reloadData()
                    self.genreMoviesTable.tableFooterView = nil
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = self.navigationController else { return }
        self.homeVCDelegate?.moveToDetailPage(model: items[indexPath.row], fromTableHeader: false, isPlayOnly: false, navCon: navigationController)
    }
    
    
}

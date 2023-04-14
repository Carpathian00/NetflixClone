//
//  MovieDetailViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var item: Item?
    
    private lazy var movieDetailLayout: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "MovieDetailTableViewCell", bundle: nil), forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
   
    
    private func setupTableView() {
        
        view.addSubview(movieDetailLayout)
        
        movieDetailLayout.backgroundColor = .systemBackground
        movieDetailLayout.separatorStyle = .none
        movieDetailLayout.tableFooterView = UIView(frame: CGRect.zero)
        movieDetailLayout.sectionFooterHeight = 0.0
        
        NSLayoutConstraint.activate([
            movieDetailLayout.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        movieDetailLayout.delegate = self
        movieDetailLayout.dataSource = self
    }
    
    private func configure(model: Item?) {
        self.item = model
    }


}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieDetailLayout.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier, for: indexPath) as? MovieDetailTableViewCell else { return UITableViewCell() }
        cell.configure(dataModel: item)
        return cell
    }
    
    
}

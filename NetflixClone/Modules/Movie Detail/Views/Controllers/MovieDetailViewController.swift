//
//  MovieDetailViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {

    private var item: Item?
    private var trailer: TrailerResult?
    private let MovieDetailVM = MovieDetailViewModel()

    
    @IBOutlet weak var videoPlayer: WKWebView!
    
    private lazy var movieDetailLayout: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "MovieDetailTableViewCell", bundle: nil), forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        callApi()
    }
    
   
    
    private func setupTableView() {
        
        view.addSubview(movieDetailLayout)
        
        movieDetailLayout.backgroundColor = .systemBackground
        movieDetailLayout.separatorStyle = .none
        movieDetailLayout.tableFooterView = UIView(frame: CGRect.zero)
        movieDetailLayout.sectionFooterHeight = 0.0
        
        NSLayoutConstraint.activate([
            movieDetailLayout.topAnchor.constraint(equalTo: videoPlayer.bottomAnchor),
            movieDetailLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        movieDetailLayout.delegate = self
        movieDetailLayout.dataSource = self
    }

    private func callApi() {
        self.MovieDetailVM.fetchTrailerData(with: self.item?.id)
        self.MovieDetailVM.bindTrailerData = { trailer in
            self.trailer = trailer
            DispatchQueue.main.async { [weak self] in
                self?.callVideoUrl(key: self?.trailer!.key ?? "")
            }
            
        }
    }
    
    private func callVideoUrl(key: String) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(key)") else {
            return
        }
        self.videoPlayer.load(URLRequest(url: url))
    }
    
    func configure(model: Item?) {
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

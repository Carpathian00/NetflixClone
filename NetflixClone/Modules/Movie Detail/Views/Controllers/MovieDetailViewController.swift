//
//  MovieDetailViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {
    
    private var isPlayOnly: Bool? = true
    private var fromTableHeader: Bool?
    private var item: Item?
    private var trailer: TrailerResult?
    private let MovieDetailVM = MovieDetailViewModel()
    var didLoadVideo = false


    
    @IBOutlet weak var videoPlayer: WKWebView!
    
    private lazy var movieDetailLayout: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "MovieDetailTableViewCell", bundle: nil), forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
//
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        videoPlayer.configuration.mediaTypesRequiringUserActionForPlayback = []
        
        setupNavigationBar()
        setupTableView()
        callApi()
    }
    
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .label
    }
    
    
    private func setupTableView() {
        
        view.addSubview(movieDetailLayout)
        
        movieDetailLayout.backgroundColor = .systemBackground
        movieDetailLayout.separatorStyle = .none
        movieDetailLayout.tableFooterView = UIView(frame: CGRect.zero)
        movieDetailLayout.sectionFooterHeight = 0.0
        
        if fromTableHeader == true  && isPlayOnly == false {
            hideVideoPlayer()
        } else if fromTableHeader == true && isPlayOnly == true {
            movieDetailLayout.isHidden = true
        } else {
           showVideoPlayer()
        }
            
        movieDetailLayout.delegate = self
        movieDetailLayout.dataSource = self
    }

    private func hideVideoPlayer() {
        videoPlayer.isHidden = true
        NSLayoutConstraint.activate([
            movieDetailLayout.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func showVideoPlayer() {
        NSLayoutConstraint.activate([
            movieDetailLayout.topAnchor.constraint(equalTo: videoPlayer.bottomAnchor),
            movieDetailLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func callApi() {
        self.MovieDetailVM.fetchTrailerData(with: self.item?.id)
        
        self.MovieDetailVM.bindTrailerData = { [weak self] trailer in
            if let trailer = trailer {
                self?.trailer = trailer
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    self?.callVideoUrl(key: self?.trailer!.key ?? "")
                    DispatchQueue.main.async { [weak self] in
                        self?.showVideoPlayer()
                    }
                }
                
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.hideVideoPlayer()
                }
            }
        }
    }
    
    private func callVideoUrl(key: String) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(key)") else {
            return
        }
        DispatchQueue.main.async {
            self.videoPlayer.load(URLRequest(url: url))
        }
            
    }
    
    func configure(model: Item?, fromTableHeader: Bool, isPlayOnly: Bool) {
        self.item = model
        self.fromTableHeader = fromTableHeader
        self.isPlayOnly = isPlayOnly
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

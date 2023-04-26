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
    var didLoadVideo = false

    
    @IBOutlet weak var videoPlayer: WKWebView! {
        didSet {
            
        }
    }
    
    private lazy var movieDetailLayout: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "MovieDetailTableViewCell", bundle: nil), forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let configuration = WKWebViewConfiguration()
//        configuration.allowsInlineMediaPlayback = true
//        configuration.mediaTypesRequiringUserActionForPlayback = .audio
//        let webView = WKWebView(frame: .zero, configuration: configuration)
//        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(leftEdgeSwipe))
//        edgePan.edges = .left
//
//        view.addGestureRecognizer(edgePan)

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate

        // Enable gesture to pop the top view controller off the navigation stack
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        // Make an extension for your View Controller
        
        // Method to go back
      
        
        
        videoPlayer.configuration.mediaTypesRequiringUserActionForPlayback = []
        
        setupNavigationBar()
        setupTableView()
        callApi()
    }
    
            
        

        var embedVideoHtml:String {
            return """
            <!DOCTYPE html>
            <html>
            <body>
            <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
            <div id="player"></div>

            <script>
            var tag = document.createElement('script');

            tag.src = "https://www.youtube.com/iframe_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

            var player;
            function onYouTubeIframeAPIReady() {
            player = new YT.Player('player', {
            playerVars: { 'autoplay': 1, 'controls': 0, 'playsinline': 1 },
            height: '\(videoPlayer.frame.height * 3)',
            width: '\(videoPlayer.frame.width * 3)',
            videoId: '\(self.trailer?.key ?? "")',
            events: {
            'onReady': onPlayerReady
            }
            });
            }

            function onPlayerReady(event) {
            event.target.playVideo();
            }
            </script>
            </body>
            </html>
            """
        }
    
    @objc func leftEdgeSwipe(_ recognizer: UIScreenEdgePanGestureRecognizer) {
       if recognizer.state == .recognized {
          self.navigationController?.popViewController(animated: true)
       }
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
//                if !self!.didLoadVideo {
//                    self!.videoPlayer.loadHTMLString(self!.embedVideoHtml, baseURL: nil)
//                    self!.didLoadVideo = true
//                }
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

//
//  MovieDetailTableViewCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit
import WebKit

class MovieDetailTableViewCell: UITableViewCell {
    
    static let identifier = "MovieDetailTableViewCell"

    @IBOutlet weak var videoPlayer: WKWebView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let scoreBar = CircularScoreBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        scoreBar.percentage = 0.60
//        contentView.addSubview(scoreBar)
    }

    func configureByMovie(dataModel: Item?, detailModel: MovieDetail?) {
        if dataModel?.originalTitle == nil {
            self.itemTitle.text = dataModel?.originalName
        } else {
            self.itemTitle.text = dataModel?.originalTitle
        }
        
        self.releaseDate.text = "Release Year: " + (detailModel?.releaseYear ?? "Unknown")
        
        self.overview.text = detailModel?.overview
        
    }
   
    func configureByTv(dataModel: Item?, detailModel: TvDetail?) {
        if dataModel?.originalTitle == nil {
            self.itemTitle.text = dataModel?.originalName
        } else {
            self.itemTitle.text = dataModel?.originalTitle
        }
        
        self.releaseDate.text = "Last Air Date: " + (detailModel?.lastAirDate ?? "Unknown")
        
        self.overview.text = detailModel?.overview
        
    }

    
}

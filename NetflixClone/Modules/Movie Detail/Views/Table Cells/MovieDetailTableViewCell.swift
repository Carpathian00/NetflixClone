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

    func configure(dataModel: Item?) {
        if dataModel?.title == nil {
            self.itemTitle.text = dataModel?.originalTitle
        } else {
            self.itemTitle.text = dataModel?.title
        }
        
        self.releaseDate.text = "Release Year: " + (dataModel?.releaseYear ?? "Unknown")
        
        self.overview.text = dataModel?.overview
        
        
    }
   
    
}

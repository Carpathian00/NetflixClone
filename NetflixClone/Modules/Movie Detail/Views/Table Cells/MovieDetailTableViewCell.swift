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
    }

    func configure(dataModel: Item?) {
        if dataModel?.title == nil {
            self.itemTitle.text = dataModel?.originalTitle
        } else {
            self.itemTitle.text = dataModel?.title
        }
        
        self.releaseDate.text = dataModel?.releaseDate
        
        self.overview.text = dataModel?.overview
        
        
    }
   
    
}

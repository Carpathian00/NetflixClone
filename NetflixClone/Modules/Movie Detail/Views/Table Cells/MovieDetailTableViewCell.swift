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

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemGenres: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var optionButtonStackView: UIStackView!
    @IBOutlet weak var scoreBar: CircularScoreBar!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func configureByMovie(dataModel: Item?, detailModel: MovieDetail?) {
        if dataModel?.originalTitle == nil {
            self.itemTitle.text = dataModel?.originalName
        } else {
            self.itemTitle.text = dataModel?.originalTitle
        }
        
        if let genreNames = detailModel?.genres?.compactMap({ $0.name }), !genreNames.isEmpty {
        self.itemGenres.text = genreNames.joined(separator: ", ")
        } else {
        self.itemGenres.text = "Unknown"
        }

        self.releaseDate.text = "Release Year: " + (detailModel?.releaseYear ?? "Unknown")
        
        self.overview.text = detailModel?.overview
        
        if let voteAverage = detailModel?.voteAverage {
            addScoreBar(voteAverage: voteAverage)
        }
    }
   
    func configureByTv(dataModel: Item?, detailModel: TvDetail?) {
        if dataModel?.originalTitle == nil {
            self.itemTitle.text = dataModel?.originalName
        } else {
            self.itemTitle.text = dataModel?.originalTitle
        }
        
        if let genreNames = detailModel?.genres?.compactMap({ $0.name }), !genreNames.isEmpty {
        self.itemGenres.text = genreNames.joined(separator: ", ")
        } else {
        self.itemGenres.text = "Unknown"
        }
        self.releaseDate.text = "Last Air Date: " + (detailModel?.formattedLastAirDate ?? "Unknown")
        
        self.overview.text = detailModel?.overview
        
        if let voteAverage = detailModel?.voteAverage {
            addScoreBar(voteAverage: voteAverage)
        }
        
    }

    private func addScoreBar(voteAverage: Double?) {
        let scoreBar = CircularScoreBar(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        scoreBar.percentage = (voteAverage ?? 0) / 10
        contentView.addSubview(scoreBar)

        scoreBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreBar.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 10),
            scoreBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            scoreBar.heightAnchor.constraint(equalToConstant: 70),
            scoreBar.widthAnchor.constraint(equalToConstant: 70),
            overview.topAnchor.constraint(equalTo: scoreBar.bottomAnchor, constant: 10),
            overview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
}

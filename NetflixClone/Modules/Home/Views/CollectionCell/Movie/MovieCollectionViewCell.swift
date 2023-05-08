//
//  MovieCollectionViewCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 10/04/23.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    
    @IBOutlet weak var movieImage: UIImageView! {
        didSet {
            movieImage.layer.cornerRadius = 5
        }
    }
    
    private lazy var rankingLabel: UILabel = {
        let rankingLabel = UILabel()
        
        rankingLabel.textColor = .secondaryLabel
        rankingLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        return rankingLabel
    }()
    
    private lazy var voteAverageLabel: UILabel = {
        let voteAverageLabel = UILabel()
        
        voteAverageLabel.textColor = .white
        voteAverageLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        return voteAverageLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addRankingLabels(rank: Int, voteAverage: CGFloat) {
        rankingLabel.text = "#\(rank)"
        voteAverageLabel.text = "\(Int(voteAverage * 10))%"
        contentView.addSubview(rankingLabel)
        contentView.addSubview(voteAverageLabel)
        
        // Add constraints for positioning the labels
        NSLayoutConstraint.activate([
            rankingLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            rankingLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 8),
            rankingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rankingLabel.widthAnchor.constraint(equalToConstant: 50),
            rankingLabel.heightAnchor.constraint(equalToConstant: 24),
            
            voteAverageLabel.topAnchor.constraint(equalTo: rankingLabel.bottomAnchor, constant: 5),
            voteAverageLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 8),
            voteAverageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            voteAverageLabel.widthAnchor.constraint(equalToConstant: 50),
            voteAverageLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    
    
    func configure(model: Item?, isTopRated: Bool, rank: Int) {
        guard let imageUrl = model?.posterPath else { return }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)")
        
        guard let vote = model?.voteAverage else { return }
        
        let formattedRank = rank + 1
        movieImage.sd_setImage(with: url)
        if isTopRated == true {
            addRankingLabels(rank: formattedRank , voteAverage: vote )
        } else {
            NSLayoutConstraint.activate([
                movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }
        
}

//
//  ViewAllTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 25/04/23.
//

import UIKit
import SDWebImage

class ViewAllMoviesTableCell: UITableViewCell {

    static let identifier = "ViewAllMoviesTableCell"
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemRank: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView! {
        didSet {
            itemImage.contentMode = .scaleAspectFill
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImage.widthAnchor.constraint(equalToConstant: 121),
            itemImage.heightAnchor.constraint(equalToConstant: 156),
        ])
    }

    func configure(itemModel: Item?, section: Int?, index: Int?) {
        guard let imagePath = itemModel?.posterPath else { return }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")

        self.itemImage.sd_setImage(with: url)
        
        if let index = index {
            itemRank.text = "#\(index)"
        }
        
        if itemModel?.originalTitle == nil {
            self.itemTitle.text = itemModel?.originalName
        } else {
            self.itemTitle.text = itemModel?.originalTitle
        }
        
        if section == 3 || section == 4 {
            createScore(score: (itemModel?.voteAverage ?? 0))
        } else {
            scoreLabel.isHidden = true
        }

        
    }
    
    private func createScore(score: Double) {
        let percentage: CGFloat = score
        scoreLabel.text = "Scores: \(Int(percentage * 10))%"
    }
    
    func cancelImageLoad() {
        self.itemImage.sd_cancelCurrentImageLoad()
        SDImageCache.shared.clearMemory()
    }
}

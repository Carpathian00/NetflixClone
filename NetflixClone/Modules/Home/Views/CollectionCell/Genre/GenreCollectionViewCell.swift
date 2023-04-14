//
//  GenreCollectionViewCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    static let identifier = "GenreCollectionViewCell"
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .magenta
            containerView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var genreLabel: UILabel! {
        didSet {
            genreLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(genreModel: Genre?) {
        self.genreLabel.text = genreModel?.name
    }
    
}

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
        }
    }
    
    @IBOutlet weak var genreLabel: UILabel! {
        didSet {
            genreLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure() {
        
    }
    
}

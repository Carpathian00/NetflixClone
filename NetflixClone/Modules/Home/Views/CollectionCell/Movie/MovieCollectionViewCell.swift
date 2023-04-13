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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(model: Item?) {
        guard let model = model?.posterPath else { return }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)")
        
        movieImage.sd_setImage(with: url)
    }
    
}

//
//  GenreCollectionViewCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit
import SDWebImage

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
    @IBOutlet weak var genreImage: UIImageView! {
        didSet {
            genreImage.layer.cornerRadius = 5
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        tintView.frame = CGRect(x: 0, y: 0, width: 2000, height: 190)
        genreImage.addSubview(tintView)
    }

    func configure(genreModel: Genre?) {
        self.genreLabel.text = genreModel?.name
        
        guard let genreModel = genreModel?.imagePath else { return }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(genreModel)")
        
        self.genreImage.sd_setImage(with: url)
    }
    
}

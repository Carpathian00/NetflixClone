//
//  SearchResultCollectionCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 05/05/23.
//

import UIKit

class SearchResultCollectionCell: UICollectionViewCell {

    static let identifier = "SearchResultCollectionCell"
    
    private let posterImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupCell() {
        contentView.addSubview(posterImageView)
    }
    
    func configure(itemModel: ItemData?) {
        
    }

}

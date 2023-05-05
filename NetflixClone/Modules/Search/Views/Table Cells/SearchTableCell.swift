//
//  SearchTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 03/05/23.
//

import UIKit
import SDWebImage

class SearchTableCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView! {
        didSet {
            itemImage.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var playImage: UIImageView!
    
    static let identifier = "SearchTableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.backgroundColor = UIColor.black.cgColor
    }

    
    func configure(itemModel: Item?) {
        guard let imagePath = itemModel?.posterPath else { return }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")

        self.itemImage.sd_setImage(with: url)
        
        if itemModel?.originalTitle == nil {
            self.itemTitle.text = itemModel?.originalName
        } else {
            self.itemTitle.text = itemModel?.originalTitle
        }
        
    }
    
    func cancelImageLoad() {
        self.itemImage.sd_cancelCurrentImageLoad()
        SDImageCache.shared.clearMemory()
    }

    
    
    
    
}

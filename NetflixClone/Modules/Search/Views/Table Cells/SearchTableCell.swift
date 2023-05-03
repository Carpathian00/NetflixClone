//
//  SearchTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 03/05/23.
//

import UIKit

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

}

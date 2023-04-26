//
//  ViewAllTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 25/04/23.
//

import UIKit

class ViewAllTableCell: UITableViewCell {

    static let identifier = "ViewAllTableCell"
    
    @IBOutlet weak var itemTitle: UILabel!
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
            itemImage.widthAnchor.constraint(equalToConstant: 131)
        ])
    }

    func configure(itemModel: Item) {
        if itemModel.title == nil {
            self.itemTitle.text = itemModel.originalTitle
        } else {
            self.itemTitle.text = itemModel.title
        }
        
    }
    
}

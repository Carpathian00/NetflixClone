//
//  FooterTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

class FooterTableCell: UITableViewCell {

    static let identifier = "FooterTableCell"
    
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.tintColor = .systemRed
            logoutButton.layer.cornerRadius = 5
            logoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  ProfileHeaderTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

class ProfileHeaderTableCell: UITableViewCell {

    static let identifier = "ProfileHeaderTableCell"
    
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var editButton: UIButton! {
        didSet {
            editButton.layer.cornerRadius = 2
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
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

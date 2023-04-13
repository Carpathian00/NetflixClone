//
//  SettingTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

class SettingTableCell: UITableViewCell {

    static let identifier = "SettingTableCell"
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var settingIcon: UIImageView! {
        didSet {
            
        }
    }
    @IBOutlet weak var settingLabel: UILabel! {
        didSet {
            settingLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    
    
}

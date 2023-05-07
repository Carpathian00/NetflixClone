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
            settingLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func configure(index: Int?) {
        if index == 0 {
            setSetting(image: UIImage(systemName: "person")!, text: "Account")
        } else if index == 1 {
            setSetting(image: UIImage(systemName: "eye")!, text: "Appearance")
        } else if index == 2 {
            setSetting(image: UIImage(systemName: "bell")!, text: "Notification")
        } else {
            setSetting(image: UIImage(systemName: "lock")!, text: "Security")
        }
    }
    
    private func setSetting(image: UIImage, text: String) {
        self.settingIcon.image = image
        self.settingLabel.text = text

    }

    
    
}

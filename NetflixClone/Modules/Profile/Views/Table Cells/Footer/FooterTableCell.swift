//
//  FooterTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit
import FirebaseAuth

class FooterTableCell: UITableViewCell {

    static let identifier = "FooterTableCell"
    var tabBarDelegate: TabBarControllerDelegate?
    var navigationController: UINavigationController?
    
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
    
    @IBAction func tapLogOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            guard let navigationController = self.navigationController else { return }
            self.tabBarDelegate?.moveToLoginPage(navCon: navigationController)
        } catch {
            print("print error")
        }
    }
    
}

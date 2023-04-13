//
//  ProfileViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/04/23.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileLayout: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "ProfileHeaderTableCell", bundle: nil), forCellReuseIdentifier: ProfileHeaderTableCell.identifier)
        table.register(UINib(nibName: "SettingTableCell", bundle: nil), forCellReuseIdentifier: SettingTableCell.identifier)
        table.register(UINib(nibName: "FooterTableCell", bundle: nil), forCellReuseIdentifier: FooterTableCell.identifier)
        
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTable()
    }

    private func setupNavigationBar() {
//        navigationController?.navigationBar.setGradientBackground(colors: [.black, .clear], locations: [0,1])
        navigationController?.hidesBarsOnSwipe = true
        
        let leftNavigationBarItems = LeftNavBarItems()
        leftNavigationBarItems.setupLeftNavBarItems()
        
        let rightNavigationBarItems = RightNavBarItems()
        rightNavigationBarItems.setupBarItem()
        
        navigationItem.setLeftBarButton(leftNavigationBarItems, animated: true)
        navigationItem.setRightBarButton(rightNavigationBarItems, animated: true)
    }
    
    func setupTable() {
        view.addSubview(profileLayout)
        
        profileLayout.backgroundColor = .systemBackground
        profileLayout.separatorStyle = .none
        profileLayout.tableFooterView = UIView(frame: CGRect.zero)
        profileLayout.sectionFooterHeight = 0.0
        
        NSLayoutConstraint.activate([
            profileLayout.topAnchor.constraint(equalTo: view.topAnchor),
            profileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        profileLayout.delegate = self
        profileLayout.dataSource = self
    }
    

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return 1
        default:
             return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let header = profileLayout.dequeueReusableCell(withIdentifier: ProfileHeaderTableCell.identifier, for: indexPath) as? ProfileHeaderTableCell else { return UITableViewCell() }
            return header
        case 1:
            guard let setting = profileLayout.dequeueReusableCell(withIdentifier: SettingTableCell.identifier, for: indexPath) as? SettingTableCell else { return UITableViewCell() }
            return setting
        case 2:
            guard let footer = profileLayout.dequeueReusableCell(withIdentifier: FooterTableCell.identifier, for: indexPath) as? FooterTableCell else { return UITableViewCell() }
            return footer

        default:
            return UITableViewCell()
        }
    }
    
    
}

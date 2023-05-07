//
//  ProfileViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/04/23.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profileVM = ProfileViewModel()
    private var profileData: Profile?
    var tabBarDelegate: TabBarControllerDelegate?
    
    private lazy var profileLayout: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SectionCellHeader.self, forHeaderFooterViewReuseIdentifier: SectionCellHeader.identifier)
        table.register(UINib(nibName: "ProfileHeaderTableCell", bundle: nil), forCellReuseIdentifier: ProfileHeaderTableCell.identifier)
        table.register(UINib(nibName: "SettingTableCell", bundle: nil), forCellReuseIdentifier: SettingTableCell.identifier)
        table.register(UINib(nibName: "FooterTableCell", bundle: nil), forCellReuseIdentifier: FooterTableCell.identifier)
        
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        fetchData()
        setupTable()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Profile"
        
    }
    
    private func fetchData() {
        profileVM.fetchData { result in
            switch result {
            case .success(let profile):
                self.profileData = profile
                DispatchQueue.main.async {
                    self.profileLayout.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupTable() {
        view.addSubview(profileLayout)
        
        profileLayout.backgroundColor = .systemBackground
        profileLayout.separatorStyle = .none
        profileLayout.tableFooterView = UIView(frame: CGRect.zero)
        profileLayout.sectionFooterHeight = 0.0
        profileLayout.backgroundColor = UIColor.clear;
        profileLayout.backgroundView = nil;

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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let header = profileLayout.dequeueReusableHeaderFooterView(withIdentifier: SectionCellHeader.identifier) as? SectionCellHeader
            header?.addSubviews()
            header?.configure(title: "Settings", index: 0)

            return header
        default:
            return UITableViewHeaderFooterView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let header = profileLayout.dequeueReusableCell(withIdentifier: ProfileHeaderTableCell.identifier, for: indexPath) as? ProfileHeaderTableCell else { return UITableViewCell() }
            header.configure(profileModel: self.profileData)
            return header
        case 1:
            guard let setting = profileLayout.dequeueReusableCell(withIdentifier: SettingTableCell.identifier, for: indexPath) as? SettingTableCell else { return UITableViewCell() }
            setting.configure(index: indexPath.row)
            return setting
        case 2:
            guard let footer = profileLayout.dequeueReusableCell(withIdentifier: FooterTableCell.identifier, for: indexPath) as? FooterTableCell else { return UITableViewCell() }
            footer.tabBarDelegate = self.tabBarDelegate
            guard let navigationController = self.navigationController else { return UITableViewCell() }
            footer.navigationController = navigationController
            return footer

        default:
            return UITableViewCell()
        }
    }
    
    
}

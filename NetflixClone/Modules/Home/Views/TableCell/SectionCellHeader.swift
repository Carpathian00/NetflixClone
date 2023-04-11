//
//  TableCellHeader.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 10/04/23.
//

import UIKit

class SectionCellHeader: UITableViewHeaderFooterView {
    static let identifier = "SectionCellHeader"
    
    private lazy var headerTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return lb
    }()
    
    private lazy var viewAllButton: UIButton = {
        let bt = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        bt.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.tintColor = UIColor.label
        return bt
    }()
    
    func addSubviews() {
        
        self.contentView.addSubview(headerTitle)
        self.contentView.addSubview(viewAllButton)
        
        setupHeaderTitle()
        setupViewAllButton()
    }
    
    func setupHeaderTitle() {
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerTitle.trailingAnchor.constraint(equalTo: viewAllButton.leadingAnchor, constant: -10),
            headerTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupViewAllButton() {
        NSLayoutConstraint.activate([
            viewAllButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            viewAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func configure(title: String) {
        headerTitle.text = title
    }

}

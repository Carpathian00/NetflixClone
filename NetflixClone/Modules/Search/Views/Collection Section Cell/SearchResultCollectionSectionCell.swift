//
//  SearchResultCollectionSectionCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/05/23.
//

import Foundation
import UIKit

class SearchResultCollectionSectionCell: UICollectionReusableView, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "SearchResultCollectionSectionCell"
    
    // Implement methods of the UICollectionViewDelegateFlowLayout protocol to configure the size and position of the header view
    // Customize the appearance of the header view as needed
    
    
    private lazy var headerTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return lb
    }()
    
    
    func addSubviews() {
        
        self.addSubview(headerTitle)
        
        setupHeaderTitle()
    }
    
    func setupHeaderTitle() {
        NSLayoutConstraint.activate([
            headerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            headerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    
    func configure(title: String) {
        headerTitle.text = title
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50) // Customize the size of the header view as needed

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0) // Customize the margins as needed
    }


}

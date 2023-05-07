//
//  MainTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 09/04/23.
//

import Foundation
import UIKit

class MainTableCell: UITableViewCell {
    
    static let identifier = "MainTableCell"
    var homeVCDelegate: TabBarControllerDelegate?
    var navigationController: UINavigationController?
    private var isTopRated: Bool?
    private var items: [Item]?
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    override class func awakeFromNib() {
        self.awakeFromNib()
    }
    
    func setupCollectionView() {
        moviesCollectionView.showsHorizontalScrollIndicator = false
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
          
    }
    
    func configure(modelData: [Item]?, isTopRated: Bool) {
        self.isTopRated = isTopRated
        self.items = modelData
        DispatchQueue.main.async { [weak self] in
            self?.moviesCollectionView.reloadData()
        }
    }
    
    
    
}

extension MainTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.isTopRated == true {
            return CGSize(width: self.frame.width / 2, height: 199)
        } else {
            return CGSize(width: self.frame.width / 3, height: 199)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        if let itemIndex = items?[indexPath.row] {
            cell.configure(model: itemIndex, isTopRated: self.isTopRated ?? false, rank: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigationController = self.navigationController else { return }
        self.homeVCDelegate?.moveToDetailPage(model: items?[indexPath.row], fromTableHeader: false, isPlayOnly: false, navCon: navigationController)
    }
}




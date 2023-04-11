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
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = MoviesCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.layer.masksToBounds = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
//    var moviesCollectionView: MoviesCollectionView?
    
    
    override class func awakeFromNib() {
        self.awakeFromNib()
        
    }
    
    func setupCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        contentView.addSubview(moviesCollectionView)
        
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            moviesCollectionView.heightAnchor.constraint(equalToConstant: self.frame.width / 2)
        ])
        
//        if bounds.size != intrinsicContentSize {
//            self.invalidateIntrinsicContentSize()
//        }
        
    }
    
//    override var intrinsicContentSize: CGSize {
//        return moviesCollectionView.collectionViewLayout.collectionViewContentSize
//    }
    
    
    
}

extension MainTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 3, height: self.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
}




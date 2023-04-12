//
//  GenresTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

class GenresTableCell: UITableViewCell {
    
    static let identifier = "GenresTableCell"
    
    private lazy var genresCollectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
           cv.layer.masksToBounds = false
           cv.showsHorizontalScrollIndicator = false
           return cv
       }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCollectionView() {
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
        genresCollectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        contentView.addSubview(genresCollectionView)
        
        genresCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            genresCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genresCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            genresCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
}

extension GenresTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = genresCollectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

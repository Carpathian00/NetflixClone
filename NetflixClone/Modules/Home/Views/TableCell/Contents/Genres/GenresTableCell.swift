//
//  GenresTableCell.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 12/04/23.
//

import UIKit

class GenresTableCell: UITableViewCell {
    
    static let identifier = "GenresTableCell"
    
    var genres: [Genre]?
    
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
        
        genresCollectionView.showsHorizontalScrollIndicator = false
        genresCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            genresCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genresCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            genresCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    func configure(genreModel: [Genre]?) {
        self.genres = genreModel
        DispatchQueue.main.async {
            self.genresCollectionView.reloadData()
        }
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
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = genresCollectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell() }
        if indexPath.row % 5 == 0 {
            cell.containerView.backgroundColor = .gray
        } else if indexPath.row % 5 == 1 {
            cell.containerView.backgroundColor = .orange
        } else if indexPath.row % 5 == 2 {
            cell.containerView.backgroundColor = .magenta
        } else if indexPath.row % 5 == 3 {
            cell.containerView.backgroundColor = .blue
        } else if indexPath.row % 5 == 4 {
            cell.containerView.backgroundColor = .brown
        }
        
        cell.configure(genreModel: genres?[indexPath.row])
        return cell
    }
    
    
}

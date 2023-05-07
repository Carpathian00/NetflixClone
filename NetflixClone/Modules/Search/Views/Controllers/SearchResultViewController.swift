//
//  SearchResultViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 01/05/23.
//

import UIKit

protocol SearchResultVCDelegate {
    func didTapSearchResultCell(itemModel: Item?)
}

enum searchResultTableSections: Int {
    case movies = 0
    case tvs = 1
}

class SearchResultViewController: UIViewController {

//    public lazy var searchResultsCollectionView: UICollectionView = {
//
//        let layout = UICollectionViewFlowLayout()
//        //for dynamic scalling
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
//        layout.minimumInteritemSpacing = 0
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
//        return collectionView
//    }()
    var delegate: SearchResultVCDelegate?
    public var movieResults: [Item]? = [Item]()
    public var tvShowResults: [Item]? = [Item]()
    private let section = ["Movies", "Tv Shows"]


    public lazy var searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.register(SearchResultCollectionSectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultCollectionSectionCell.identifier)
        cv.layer.masksToBounds = false
        cv.showsHorizontalScrollIndicator = false
        return cv
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    
    }

    private func setupCollectionView() {
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchResultsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        searchResultsCollectionView.frame = view.bounds
//    }



}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultCollectionSectionCell.identifier, for: indexPath) as! SearchResultCollectionSectionCell
            // Customize the header view as needed, based on the section that it will represent
            headerView.addSubviews()
            headerView.configure(title: self.section[indexPath.section])
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60) // Customize the size of the header view as needed
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let resultSections = searchResultTableSections(rawValue: indexPath.section)
        switch resultSections {
        case .movies:
            guard let cell = searchResultsCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            
            if let movieResults = self.movieResults, movieResults.count > indexPath.row {
                cell.configure(model: movieResults[indexPath.row], isTopRated: false, rank: indexPath.row)
            } else {
                print("kosong indexnya")
            }
            return cell
        case .tvs:
            guard let cell = searchResultsCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell()}
            
            if let tvResults = self.tvShowResults, tvResults.count > indexPath.row {
                cell.configure(model: tvResults[indexPath.row], isTopRated: false, rank: indexPath.row)
            } else {
                print("kosong indexnya")
            }
            return cell
        default:
            print("error search result cell")
            
            return UICollectionViewCell()

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resultSections = searchResultTableSections(rawValue: indexPath.section)

        switch resultSections {
        case .movies:
            self.delegate?.didTapSearchResultCell(itemModel: self.movieResults?[indexPath.row])
        case .tvs:
            self.delegate?.didTapSearchResultCell(itemModel: self.tvShowResults?[indexPath.row])
        default:
            print("search result delegate error")
        }
        
        
            
        
    }
    
    
    
}

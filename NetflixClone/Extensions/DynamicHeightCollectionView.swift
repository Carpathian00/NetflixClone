//
//  DynamicHeightCollectionView.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 11/04/23.
//

import Foundation
import UIKit

class DynamicHeightCollectionView: UICollectionView {

override func layoutSubviews() {

super.layoutSubviews()

if bounds.size != intrinsicContentSize {

self.invalidateIntrinsicContentSize()

}

}

override var intrinsicContentSize: CGSize {

return collectionViewLayout.collectionViewContentSize

}

}

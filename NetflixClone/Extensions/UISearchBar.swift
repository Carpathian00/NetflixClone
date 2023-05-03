//
//  UISearchBar.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 03/05/23.
//

import Foundation
import UIKit

extension UISearchBar {
    func setCenteredPlaceholder() {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField

            //get the sizes
            let searchBarWidth = self.frame.width
            let placeholderIconWidth = textFieldInsideSearchBar?.leftView?.frame.width
            let placeHolderWidth = textFieldInsideSearchBar?.attributedPlaceholder?.size().width
            let offsetIconToPlaceholder: CGFloat = 8
            let placeHolderWithIcon = placeholderIconWidth! + offsetIconToPlaceholder

            let offset = UIOffset(horizontal: ((searchBarWidth / 2) - (placeHolderWidth! / 2) - placeHolderWithIcon), vertical: 0)
            self.setPositionAdjustment(offset, for: .search)
    }
}

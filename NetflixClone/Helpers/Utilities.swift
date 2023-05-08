//
//  Utilities.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 04/05/23.
//

import Foundation
import UIKit

class Utilities {
    
    static func createErrorLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

}

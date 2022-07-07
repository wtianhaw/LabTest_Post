//
//  UICollectionViewCell+Extension.swift
//  LabTest
//
//  Created by Wong Tian Haw on 07/07/2022.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    class var identifier: String { return String.className(self) }
    
    static func getNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

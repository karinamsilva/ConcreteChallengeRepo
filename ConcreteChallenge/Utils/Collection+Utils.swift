//
//  Collection+Utils.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation
import UIKit

extension UICollectionViewDelegateFlowLayout {
    func collectionSize(with size: CGFloat) -> CGSize {
        let padding: CGFloat = 50
        let collectionSize = size - padding
        return CGSize(width: collectionSize/2, height: collectionSize - 90)
    }
}

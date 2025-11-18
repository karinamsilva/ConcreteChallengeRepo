//
//  Extension.swift
//  ConcreteChallenge
//
//  Created by Karina on 16/07/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(fromString: String) {
        guard let url = URL(string: fromString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

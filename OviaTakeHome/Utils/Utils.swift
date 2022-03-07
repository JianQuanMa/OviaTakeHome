//
//  Utils.swift
//  OviaTakeHome
//
//  Created by Jian Ma on 3/6/22.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

extension String {
    func log() {
        print(self)
    }
    
    func getStars() -> String {
        let ratingDouble = (self as NSString).doubleValue
        let numberOfStars = Int(ratingDouble / 2)
        var result = ""
        for _ in 0..<numberOfStars {
            result.append("⭐")
        }
        return result
    }
    
    func getAccessibilityStars() -> String {
        let ratingDouble = (self as NSString).doubleValue
        let numberOfStars = Int(ratingDouble / 2)
        return "\(numberOfStars) out of five stars"
    }
}

extension UIAlertController {
    static var custom: UIAlertController {
        UIAlertController(title: "error", message: "Movie not found", preferredStyle: .alert).then{
            $0.addAction(UIAlertAction(title: "done", style: .default))
        }
    }
}

protocol Then {}

extension NSObject: Then {}

extension Then where Self: AnyObject {
    @inlinable
    func then(_ block: (Self) throws -> Void ) rethrows -> Self {
        try block(self)
        return self
    }
}

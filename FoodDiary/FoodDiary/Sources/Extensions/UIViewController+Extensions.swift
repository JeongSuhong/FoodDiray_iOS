//
//  UIViewController+Extensions.swift
//  FoodDiary
//
//  Created by JeongSuhong on 2023/08/13.
//

import Foundation
import UIKit

extension UIViewController {
    static func make<T>(ofType type: T.Type = T.self) -> T where T:UIViewController {
        guard let vc = UIStoryboard(name: String(describing: T.self), bundle: nil).instantiateInitialViewController() as? T else {
            fatalError()
        }
        return vc
    }
}

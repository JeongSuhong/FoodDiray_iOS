//
//  UIApplication+Extensions.swift
//  FoodDiary
//
//  Created by JeongSuhong on 2023/08/13.
//

import Foundation
import UIKit

extension UIApplication {
    var topVC: UIViewController? {
        if let tabVC = self.delegate?.window??.rootViewController as? UITabBarController {
            if let navVC = tabVC.selectedViewController as? UINavigationController {
                return navVC.topViewController?.presentedViewController ?? navVC.topViewController
            } else {
                return tabVC.selectedViewController?.presentedViewController ?? tabVC.selectedViewController
            }
        } else if let navVC = self.delegate?.window??.rootViewController as? UINavigationController {
            return navVC.topViewController?.presentedViewController ?? navVC.topViewController
        } else {
            return self.delegate?.window??.rootViewController?.presentedViewController ?? self.delegate?.window??.rootViewController
        }
    }
}

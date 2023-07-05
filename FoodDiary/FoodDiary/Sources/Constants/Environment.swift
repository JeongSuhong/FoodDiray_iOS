//
//  Environment.swift
//  FoodDiary
//
//  Created by JeongSuhong on 2023/07/05.
//

import Foundation

struct Environment {
    static let firebaseResource = Bundle.main.object(forInfoDictionaryKey: "FIREBASE_RESOURCE") as! String
}

//
//  MainTabType.swift
//  CleanArchitecture
//
//  Created by 김서진 on 1/12/25.
//

import Foundation
import SwiftUI

enum MainTabType: String, CaseIterable {
    case home
    case cultureCenter
    case coupon
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .cultureCenter:
            return "문화센터"
        case .coupon:
            return "쿠폰"
        }
    }
    
    func imageName(selected: Bool) -> String {
        switch self {
        case .home:
            "house.fill"
        case .cultureCenter:
            "bag.fill"
        case .coupon:
            "ticket.fill"
        }
        
    }
}

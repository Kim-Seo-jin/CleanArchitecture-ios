//
//  TestProject.swift
//  TestProject
//
//  Created by Junyoung on 1/8/25.
//

import SwiftUI
import Domain
import CoreKit

@main
struct TestProject: App {
    init() {
        // DI 컨테이너 설정 등 초기 설정 진행.
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                let couponBuilder = CouponBuilder()
                couponBuilder.build()
            }
        }
    }
}

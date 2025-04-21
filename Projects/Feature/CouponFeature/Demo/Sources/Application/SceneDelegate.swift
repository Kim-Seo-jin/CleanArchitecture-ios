//
//  SceneDelegate.swift
//  CleanArchitecture
//
//  Created by Chaekyeong Lee on 1/5/25.
//

import Foundation
import SwiftUI
import Data
import Domain
import NetworkModule

public class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    public var window: UIWindow?

    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // CouponBuilder를 통해 CouponScreen 생성
        let couponBuilder = CouponBuilder()
        let couponScreen = couponBuilder.build()
        
        // SwiftUI View를 window의 rootView로 설정
        window.rootViewController = UIHostingController(rootView: couponScreen)
        window.makeKeyAndVisible()
        self.window = window
    }

    public func sceneDidDisconnect(_ scene: UIScene) {

    }

    public func sceneDidBecomeActive(_ scene: UIScene) {

    }

    public func sceneWillResignActive(_ scene: UIScene) {

    }

    public func sceneWillEnterForeground(_ scene: UIScene) {

    }

    public func sceneDidEnterBackground(_ scene: UIScene) {

    }


}


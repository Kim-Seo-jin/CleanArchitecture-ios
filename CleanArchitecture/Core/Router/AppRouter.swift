import SwiftUI
import Combine

/**
 앱 전체의 네비게이션 상태를 관리하는 라우터 시스템입니다.
 
 TabNavigationManager는 각 탭별 네비게이션 경로를 관리하고,
 AppRouter는 탭 간 전환 및 전체 네비게이션 흐름을 조정합니다.
 
 주요 기능:
 - 탭별 독립적인 네비게이션 스택 관리
 - 탭 간 전환 및 특정 경로로 이동
 - push, pop, popToRoot 등 네비게이션 액션 처리
 */

// 탭별 내비게이션 관리자 (단일 경로 관리)
class TabNavigationManager<R: NavigationRoute>: NavigationManaging {

    var objectWillChange = ObservableObjectPublisher()
    
    // 단일 경로 스택 (모든 iOS 버전용)
    @Published var routes: [R] = [] {
        didSet {
            print("Routes updated: \(routes.count)")
            objectWillChange.send()
        }
    }
    
    func push(_ route: R) {
        print("Pushing route: \(route)")
        routes.append(route)
    }
    
    func pop() {
        if !routes.isEmpty {
            routes.removeLast()
        }
    }
    
    func popToRoot() {
        routes.removeAll()
    }
    
    func present(_ route: R) {
        print("Present route: \(route)")
        routes.append(route)
    }
    
    func dismiss() {
        if !routes.isEmpty {
            routes.removeLast()
        }
    }
    
}

// 앱 전체 라우팅을 관리하는 클래스
class AppRouter: ObservableObject {
    // 각 탭별 내비게이션 관리자
    @Published var homeNavigator = TabNavigationManager<HomeRoute>()
    @Published var cultureCenterNavigator = TabNavigationManager<CultureCenterRoute>()
    @Published var couponNavigator = TabNavigationManager<CouponRoute>()
    
    // 현재 선택된 탭
    @Published var selectedTab: MainTabType = .home
    @Published var isTabViewVisible: Bool = true
    // Present용 뷰 상태값
    @Published var presentedRouteView: AnyView? = nil
    @Published var isPresenting = false
    @Published var shouldPresentModal = false
    
    func presentModal() {
        shouldPresentModal = true
    }

    func dismissModal() {
        self.shouldPresentModal = false
        self.isPresenting = false
        self.presentedRouteView = nil
    }
    
    // 특정 탭으로 이동
    func switchTab(to tab: MainTabType) {
        selectedTab = tab
    }
    
    // 내비게이션 액션 처리
    func navigate(_ action: NavigationAction, route: Any? = nil) {
        switch selectedTab {
        case .cultureCenter:
            performNavigation(action, route: route as? CultureCenterRoute, navigator: cultureCenterNavigator)
        case .coupon:
            performNavigation(action, route: route as? CouponRoute, navigator: couponNavigator)
        case .home:
            performNavigation(action, route: route as? HomeRoute, navigator: homeNavigator)
        }
    }
    
    func navigateToOtherView(_ action: NavigationAction, nativeScreenName: NativeScreenName, route: Any? = nil) {
        switch nativeScreenName {
        case .cultureCenter:
            performNavigation(action, route: route as? CultureCenterRoute, navigator: cultureCenterNavigator)
        case .coupon:
            performNavigation(action, route: route as? CouponRoute, navigator: couponNavigator)
        case .home:
            performNavigation(action, route: route as? HomeRoute, navigator: homeNavigator)
        case .NativePushScreen:
            performNavigation(action, route: route as? HomeRoute, navigator: homeNavigator)
            
        case .NativePresentScreen:
            performNavigation(action, route: route as? HomeRoute, navigator: homeNavigator)
        }
    }
    
    func performNavigation<R: NavigationRoute>(_ action: NavigationAction, route: R?, navigator: TabNavigationManager<R>) {
        DispatchQueue.main.async {
            switch action {
            case .push:
                if let route = route {
                    navigator.push(route)
                    self.objectWillChange.send()
                }
            case .pop:
                navigator.pop()
                self.objectWillChange.send()
            case .popToRoot:
                navigator.popToRoot()
                self.objectWillChange.send()
            case .present:
                if let route = route {
                    self.presentedRouteView = self.convertToView(route: route)
                    self.isPresenting = true
                    self.objectWillChange.send()
                }
            case .navigateToTab(let tab, let route):
                self.selectedTab = tab
                if let route = route {
                    self.navigate(.push, route: route)
                }
            }
        }
    }
    
    // 다른 탭으로 이동하면서 특정 화면까지 이동 (unwind 기능)
    func navigateToTab(_ tab: MainTabType, route: Any? = nil) {
        DispatchQueue.main.async {
            self.selectedTab = tab
            
            // 해당 탭에 라우트 추가
            if let route = route {
                self.navigate(.push, route: route)
            }
        }
    }
    
    //
    private func convertToView<R: NavigationRoute>(route: R) -> AnyView {
        // 라우트 타입에 따라 화면 분기
        if route is HomeRoute {
            return AnyView(NativePresentScreen())
        } else if route is CouponRoute {
            return AnyView(CouponScreen(couponViewModel: DIContainer.shared.resolve(CouponViewModel.self)!))
        } else {
            return AnyView(EmptyView())
        }
    }
}

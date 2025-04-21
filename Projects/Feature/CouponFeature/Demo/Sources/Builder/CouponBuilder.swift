//
//  CouponBuilder.swift
//  CleanArchitecture
//
//  Created by Chaekyeong Lee on 3/31/25.
//

import Foundation
import Swinject
import CoreKit
import Domain
import NetworkModule
import Data

public final class CouponAssembly: Assembly {
    public func assemble(container: Container) {
        // Register CouponService
        container.register(CouponServiceProtocol.self) { _ in
            CouponService()
        }
        
        // Register Repository
        container.register(CouponRepositoryInterface.self) { r in
            guard let service = r.resolve(CouponServiceProtocol.self) else {
                fatalError("CouponService could not be resolved")
            }
            return CouponRepository(couponService: service)
        }
        
        // Register UseCase
        container.register(CouponUsecase.self) { r in
            guard let repository = r.resolve(CouponRepositoryInterface.self) else {
                fatalError("CouponRepository could not be resolved")
            }
            return CouponUsecase(couponRepository: repository)
        }
        
        // Register ViewModel
        container.register(CouponViewModel.self) { r in
            guard let useCase = r.resolve(CouponUsecase.self) else {
                fatalError("CouponUsecase could not be resolved")
            }
            return CouponViewModel(couponUsecase: useCase)
        }
    }
}

public final class CouponBuilder {
    private let container: Container
    
    public init() {
        // 피처별 독립적인 컨테이너 생성
        self.container = Container()
        
        // Assembly를 사용하여 의존성 등록
        let assembly = CouponAssembly()
        assembly.assemble(container: container)
    }
    
    public func build() -> CouponScreen {
        guard let viewModel = container.resolve(CouponViewModel.self) else {
            fatalError("CouponViewModel could not be resolved")
        }
        return CouponScreen(couponViewModel: viewModel)
    }
    
//    public static func sendView() -> CouponScreen {
//        @Injected var couponRepository: CouponRepositoryInterface
////        let coreDI = DIContainer.shared
////
////        // 의존성 주입
////        let repository = coreDI.resolve(CouponRepositoryInterface.self)!
//        let useCase = CouponUsecase(couponRepository: couponRepository)
//        let viewModel = CouponViewModel(couponUsecase: useCase)
//
//        return CouponScreen(router: AppRouter(), couponViewModel: viewModel)
//    }
}


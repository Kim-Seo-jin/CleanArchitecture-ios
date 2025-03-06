//
//  CouponView.swift
//  CleanArchitecture
//
//  Created by 김서진 on 1/12/25.
//

import SwiftUI
import Kingfisher

struct CouponScreen: View {
    //@StateObject var viewModel: CouponViewModel
    @EnvironmentObject private var router: AppRouter

    @ObservedObject var store: CouponStore
    
    var body: some View {
        ZStack {
            CouponListView(
                coupons: store.couponList?.coupons ?? [], 
                onAction: { action in
                    switch action {
                    case .select(let coupon):
                        router.navigate(.push, route: CouponRoute.couponDetail(coupon))
                        
                    default:
                        store.handleAction(action)
                    }
                }
            )
            // .navigationDestination(isPresented: $isPresented) {
            //     if let coupon = selectedCoupon {
            //         CouponDetailView(coupon: coupon)
            //     }
            // }
            .onAppear {
                store.loadCouponList()
            }
            .toast(message: store.toastMessage, isPresented: $store.showToast)
        }
        
        
        
        
    }
}

#Preview {
    // DIContainer 사용 이전
    //    let couponRepository = CouponRepository(networkManager: .shared)
    //    let couponService = CouponService(repository: couponRepository)
    //    CouponView(viewModel: CouponViewModel(couponService: couponService))
    
    // DIContainer(Swinject) 사용시 이렇게
    let store = DIContainer.shared.resolve(CouponStore.self)
    
    NavigationStack {
        CouponScreen(store: store!)
    }
    
    
}

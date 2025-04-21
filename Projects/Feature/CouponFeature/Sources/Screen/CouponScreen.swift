//
//  CouponView.swift
//  CleanArchitecture
//
//  Created by 김서진 on 1/12/25.
//

import SwiftUI
import CoreKit
import Domain

public struct CouponScreen: View {
    @ObservedObject var couponViewModel: CouponViewModel
    @State private var selectedCoupon: CouponEntity?
    @State private var isPushActive = false

    public init(couponViewModel: CouponViewModel) {
        self.couponViewModel = couponViewModel
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                CouponListView(
                    coupons: couponViewModel.couponList ?? [],
                    onAction: { action in
                        switch action {
                        case .select(let coupon):
                            // router.navigate(.push, route: CouponRoute.couponDetail(coupon))
                            selectedCoupon = coupon
                            isPushActive = true
                        default:
                            couponViewModel.handleAction(action)
                        }
                    }
                )
                .onAppear {
                    couponViewModel.loadCouponList()
                }
                // .toast(message: couponViewModel.toastMessage ?? "", isPresented: $couponViewModel.showToast) -- 이거 왜오류나냐
            }
            .navigationTitle("쿠폰")
            NavigationLink(isActive: $isPushActive) {
                if let coupon = selectedCoupon {
                    CouponDetailView(coupon: coupon)
                } else {
                    EmptyView()
                }
            } label: {
                EmptyView()
            }
        }
        
    }
}

//
//  HomeEntity.swift
//  CleanArchitecture
//
//  Created by Chaekyeong Lee on 3/3/25.
//

import Foundation

struct HomeEntityList {
    let list: [HomeEntity]
}

struct HomeEntity {
    let foodBannerList: [homeBanner]
    let trendBannerList: [homeBanner]
    let noticeBannerList: [homeBanner]
}

struct homeBanner {
    let image: String
    let dcRate: String
    let price: String
    let link: String
    let badgeNm: String
    let place: String
    let originPrice: String
    let title: String
    let descript: String
    
    public init(image: String, dcRate: String, price: String, link: String, badgeNm: String, place: String, originPrice: String, title: String, descript: String) {
        self.image = image
        self.dcRate = dcRate
        self.price = price
        self.link = link
        self.badgeNm = badgeNm
        self.place = place
        self.originPrice = originPrice
        self.title = title
        self.descript = descript
    }
}

//
//  AppsSection.swift
//  AppStoreLayout
//
//  Created by Juan Laube on 6/8/19.
//  Copyright © 2019 Juan Laube. All rights reserved.
//

import Foundation

enum AppsSectionLayout {
    case galleryLarge
    case galleryMedium
    case iconsLarge
    case iconsMedium
    case iconsSmall
    case categories
    case footer
}

struct AppsSection: Hashable {
    var id: UUID
    var title: String
    var layout: AppsSectionLayout
    var items: [Int]
}

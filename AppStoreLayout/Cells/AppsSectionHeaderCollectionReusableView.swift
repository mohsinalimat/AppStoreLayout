//
//  AppsSectionHeaderCollectionReusableView.swift
//  AppStoreLayout
//
//  Created by Juan Laube on 6/9/19.
//  Copyright © 2019 Juan Laube. All rights reserved.
//

import UIKit

class AppsSectionHeaderCollectionReusableView: UICollectionReusableView {

    static var nib = UINib(nibName: nibName, bundle: .main)
    static var nibName = "AppsSectionHeaderCollectionReusableView"
    static var reuseIdentifier = "AppsSectionHeaderCollectionReusableView"

    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

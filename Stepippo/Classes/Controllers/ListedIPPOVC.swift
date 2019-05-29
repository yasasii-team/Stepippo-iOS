//
//  ListedIPPOVC.swift
//  Stepippo
//
//  Created by Sab on 2019/5/26.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import UIKit
import XLPagerTabStrip

final class ListedIPPOVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
        settings.style.buttonBarItemTitleColor = .white
        settings.style.selectedBarBackgroundColor = .cyan
        settings.style.buttonBarMinimumLineSpacing = 0
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let stockedIppoVC = UIStoryboard(name: "StockedIPPO", bundle: nil).instantiateInitialViewController() as! StockedIPPOVC
        let achievedIppoVC = UIStoryboard(name: "AchievedIPPO", bundle: nil).instantiateInitialViewController() as! AchievedIPPOVC
        return [stockedIppoVC, achievedIppoVC]
    }
}

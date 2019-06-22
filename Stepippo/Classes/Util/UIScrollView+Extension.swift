//
//  UIScrollView+Extension.swift
//  Stepippo
//
//  Created by tgaiacontentsdev on 2019/06/22.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import UIKit

// ListedIPPOVCのスワイプ競合対応
extension UIScrollView {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        // TableViewのScrollが切れないようにする
        guard type(of: self) == UIScrollView.self else { return view }
        
        if let v = view {
            // UITableViewCellContentView型を直接扱えないため文字列にして比較
            self.isScrollEnabled = String(describing:type(of: v)) != "UITableViewCellContentView"
        }
        return view
    }
}

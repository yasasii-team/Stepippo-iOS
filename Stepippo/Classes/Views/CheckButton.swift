//
//  ProgCheckButton.swift
//  Stepippo
//
//  Created by 加藤彩那 on 5/9/31 H.
//  Copyright © 31 Heisei Yasasii-kai. All rights reserved.
//

import UIKit

final class CheckButton: UIButton {
    // Images
    let checkedImage = UIImage(named: "Check_on")!
    let uncheckedImage = UIImage(named: "Check_off")!
        
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked {
                setImage(checkedImage, for: UIControl.State.normal)
            } else {
                setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        addTarget(self, action:#selector(buttonClicked(sender:)), for:UIControl.Event.touchUpInside)
        isChecked = false
    }
    
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked.toggle()
        }
    }
}

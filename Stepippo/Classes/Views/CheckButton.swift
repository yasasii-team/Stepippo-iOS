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
    let checkedImage = UIImage(named: "Checkbox")! as UIImage
    let uncheckedImage = UIImage(named: "UnCheckbox")! as UIImage
        
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for:UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked.toggle()
        }
    }
}

//
//  SubtitleAndIconCell.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/04/21.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import UIKit

class SubtitleAndIconCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func configure(image: UIImage, title: String, subtitle: String) {
        iconImage.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

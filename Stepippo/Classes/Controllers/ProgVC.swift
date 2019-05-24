//
//  ProgVC.swift
//  Stepippo
//
//  Created by 加藤彩那 on 5/2/31 H.
//  Copyright © 31 Heisei Yasasii-kai. All rights reserved.
//

import UIKit

class ProgVC: UIViewController {

    
    @IBAction func checkClicked1(_ sender: CheckButton) {
        print(sender.isChecked)
    }
    
    @IBAction func checkClicked2(_ sender: CheckButton) {
        print(sender.isChecked)
    }
    
    @IBAction func checkClicked3(_ sender: CheckButton) {
        print(sender.isChecked)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ProgVC.swift
//  Stepippo
//
//  Created by 加藤彩那 on 5/2/31 H.
//  Copyright © 31 Heisei Yasasii-kai. All rights reserved.
//

import UIKit

class ProgVC: UIViewController {

    
    @IBAction private func checkClicked1(_ sender: CheckButton) {
         animate(button: sender)
    }
    
    @IBAction func checkClicked2(_ sender: CheckButton) {
         animate(button: sender)
    }
    
    @IBAction func checkClicked3(_ sender: CheckButton) {
         animate(button: sender)
    }
    
    private func animate(button: UIButton) {
        UIView.animate(withDuration: 0.1,
                       delay: 0.1,
                       options: [.curveLinear, .autoreverse],
                       animations: {
                        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)},
                       completion: { _ in
                        button.transform = CGAffineTransform.identity
                        button.isSelected.toggle()
        })
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

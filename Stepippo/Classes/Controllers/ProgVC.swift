//
//  ProgVC.swift
//  Stepippo
//
//  Created by 加藤彩那 on 5/2/31 H.
//  Copyright © 31 Heisei Yasasii-kai. All rights reserved.
//

import UIKit

final class ProgVC: UIViewController {

    
    @IBAction func checkClicked1(_ sender: CheckButton) {
        print(sender.isChecked)
    }
    
    @IBAction func checkClicked2(_ sender: CheckButton) {
        print(sender.isChecked)
    }
    
    @IBAction func checkClicked3(_ sender: CheckButton) {
        print(sender.isChecked)
    }
    
    @IBAction func showActionSheet() {
        // アクションシートのタイトルとメッセージ
        let actionSheet = UIAlertController(title: "期間変更", message: "達成したい目標期間を選択してください", preferredStyle: .actionSheet)
        
        // 選択肢と、選択肢ごとの処理
        // handlerで指定した処理が、ボタン押下時に行われる
        let period1 = UIAlertAction(title: "毎日", style: .default, handler: actionSheetChoose(sender:))
        let period2 = UIAlertAction(title: "毎週", style: .default, handler: actionSheetChoose(sender:))
        let period3 = UIAlertAction(title: "毎月", style: .default, handler: actionSheetChoose(sender:))
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action: UIAlertAction) -> Void in
            print("キャンセルしました")
        })
        // アクションシートに、定義した選択肢を追加する
        actionSheet.addAction(period1)
        actionSheet.addAction(period2)
        actionSheet.addAction(period3)
        actionSheet.addAction(cancel)
        
        // アクションシートを表示する
        present(actionSheet, animated: true, completion: nil)
    }
    
    // アクションシートで選択した時の処理
    func actionSheetChoose(sender: UIAlertAction) {
        print("\(sender.title!)に変更しました")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

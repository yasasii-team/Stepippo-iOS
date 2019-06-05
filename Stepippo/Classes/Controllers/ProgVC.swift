//
//  ProgVC.swift
//  Stepippo
//
//  Created by 加藤彩那 on 5/2/31 H.
//  Copyright © 31 Heisei Yasasii-kai. All rights reserved.
//

import UIKit

final class ProgVC: UIViewController {
    
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
    
    @IBAction func didTapSeselectPeriodButton() {
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
    private func actionSheetChoose(sender: UIAlertAction) {
        
        // UserDefaults のインスタンス
        let userDefaults = UserDefaults.standard
        // 選択した期間を「deadlineCycle」という名前(key)でUserDefaultsに保存する
        userDefaults.set(sender.title, forKey: "deadlineCycle")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UserDefaults のインスタンス
        let userDefaults = UserDefaults.standard
        // UserDefaultsに今保存した値を確認する
        let nowDeadlineCycle = userDefaults.string(forKey: "deadlineCycle") ?? "deadlineCycleは保存されていません"
        print("期間設定: \(nowDeadlineCycle)")
    }
}

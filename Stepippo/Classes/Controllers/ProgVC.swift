//
//  ProgVC.swift
//  Stepippo
//
//  Created by 加藤彩那 on 5/2/31 H.
//  Copyright © 31 Heisei Yasasii-kai. All rights reserved.
//

import UIKit

final class ProgVC: UIViewController, IPPORepository {
    
    @IBOutlet private weak var cycleLabel: UILabel!
    
    @IBOutlet private weak var achievedLabel: UILabel!
    
    @IBAction private func checkClicked1(_ sender: CheckButton) {
        animate(button: sender)
    }
    
    @IBAction private func checkClicked2(_ sender: CheckButton) {
        animate(button: sender)
    }
    
    @IBAction private func checkClicked3(_ sender: CheckButton) {
        animate(button: sender)
    }
    //チェックボタンのアニメーション
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
    
    @IBAction private func didTapSeselectPeriodButton() {
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
    
    //設定期間に応じた、残り期間の算出
    func calcRemainingPeriod() -> String {
        // 現在時刻を取得
        let today = Date()
        // UserDefaultsのインスタンス
        let userDefaults = UserDefaults.standard
        // カレンダーのインスタンス
        let calendar = Calendar.current
        // 条件として、UserDefaultsに保存した期日サイクルを取得して使う
        switch userDefaults.string(forKey: "deadlineCycle") {
            
        case "毎日":
            // UserDefaultsで保存してある曜日設定を取得
            let timeOfDayToStart = userDefaults.integer(forKey: "timeOfDayToStart")
            // 時間を計算
            let endday = calendar.date(bySetting: .hour, value: timeOfDayToStart, of: today)
            // // 上記で算出した時間と現時刻の差分を取得する
            let remaining = calendar.dateComponents([.hour, .minute], from: today, to: endday!)
            
            return "残り\(remaining.hour!)時間\(remaining.minute!)分"
            
        case "毎週":
            // UserDefaultsで保存してある曜日設定を取得
            let dayOfWeekToStart = userDefaults.integer(forKey: "dayOfWeekToStart") + 1
            // 期日を計算
            let nextPeriod = calendar.date(bySetting: .weekday, value: dayOfWeekToStart, of: today)
            // 残り日数を計算
            let remaining = calendar.dateComponents([.day, .hour], from: today, to: nextPeriod!)
            //残り0日のときに時間のみを出力する
            if remaining.day! == 0 {
                return "残り\(remaining.hour!)時間"
            }
            return "残り\(remaining.day!)日\(remaining.hour!)時間"
            
        case "毎月":
            userDefaults.register(defaults: ["dayOfMonthToStart": 1])
            let dayOfMonthToStart = userDefaults.integer(forKey: "dayOfMonthToStart")
            // 取得した日付情報(Int)でDateComponentsを生成する
            let components = DateComponents(day: dayOfMonthToStart)
            // 次の「指定された日付」に当てはまる日付情報を取得する（例: 31日なら今月末の日付）
            let deadline = calendar.nextDate(after: today, matching: components, matchingPolicy: .nextTime)
            // 上記で算出した日付と今日の日付の差分を取得する
            let remaining = calendar.dateComponents([.day, .hour], from: today, to: deadline!)
            
            return "残り\(remaining.day!)日"
            
        default:
            // TODO: 定数化してdefaultsを使わない実装にする
            return "TODO: default"
        }
    }
    //設定IPPO（タスク）に応じた達成数の算出
    private func numberOfIPPO() -> String {
        //達成数を取得する
        //未達成の数
    let numberOfChallengingIPPO = fetch(predicate: NSPredicate(format: "_status = %@", argumentArray:[IPPOStatus.challenging.rawValue])).count
        //達成中の数
    let numberOfPerformedIPPO = fetch(predicate: NSPredicate(format: "_status = %@", argumentArray:[IPPOStatus.performed.rawValue])).count
        //未達成と達成中の数を加算し、挑戦中の数を算出する
    let currentIPPO = numberOfPerformedIPPO + numberOfChallengingIPPO
        
        return "達成数 \(numberOfPerformedIPPO)/\(currentIPPO)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //残り期間
        let result = calcRemainingPeriod()
        
        cycleLabel.text = result
        //達成数
        let progressIPPO = numberOfIPPO()
        
        achievedLabel.text = progressIPPO
    }
}

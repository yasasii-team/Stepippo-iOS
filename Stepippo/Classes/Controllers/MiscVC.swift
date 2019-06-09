//
//  MiscVC.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/04/07.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import UIKit

/// その他、設定などの雑多なことを請け負う画面
final class MiscVC: UIViewController {
    
    // MARK: IBOutlet properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    let userDefault = UserDefaults.standard

    // MARK: IBAction methods
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "その他"
        // Cellに使うXibファイル
        tableView.register(UINib(nibName: "MiscCell", bundle: nil), forCellReuseIdentifier: "miscCell")
        tableView.register(UINib(nibName: "SelectableCell", bundle: nil), forCellReuseIdentifier: "selectableCell")
    }
}

// MARK: - Private fields
private extension MiscVC {
    
    // MARK: Private Enum
    private enum Section: Int, CaseIterable {
        
        case setting
        case aboutThisApp
        
        enum Setting: Int, CaseIterable {
            case firstViewOfIppoList
            case timeToStart
            case dayOfWeekToStart
            case dateToStart
        }
        
        enum AboutThisApp: Int, CaseIterable {
            case reviewOnAppStore
            case browseRepository
            case featureRequest
            case bugReport
            case AboutYasasiiKai
        }
    }
}

// MARK: - TableView data source
extension MiscVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .setting:
            return Section.Setting.allCases.count
            
        case .aboutThisApp:
            return Section.AboutThisApp.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let section = Section(rawValue: section) else { return nil }
        
        switch section {
        case .setting:
            return "ユーザー設定"
            
        case .aboutThisApp:
            return "このアプリについて"
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        guard let section = Section(rawValue: section) else { return nil }
        
        switch section {
        case .setting:
            return "アプリを削除すると設定も削除されます"
            
        case .aboutThisApp:
            return "Stepippo (v1.0.0) Developed by やさしい会 iOSチーム"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("存在しないセクションを表示しようとしています")
        }
        
        switch section {
        // MARK: Setting section
        case .setting:
            
            guard let row = Section.Setting(rawValue: indexPath.row) else {
                fatalError("存在しない行を表示しようとしています")
            }
            
            switch row {
            case .firstViewOfIppoList:
                let cell = tableView.dequeueReusableCell(withIdentifier: "selectableCell", for: indexPath) as! SelectableCell
                cell.iconImage.image = #imageLiteral(resourceName: "TaskCompleted")
                cell.titleLabel.text = "最初に表示するIppo"
                cell.segmentedControl.setTitle("達成済み", forSegmentAt: 0)
                cell.segmentedControl.setTitle("ストック", forSegmentAt: 1)
                // UserDefaultsに記憶している設定を使用
                if let selectedSegment = userDefault.string(forKey: "firstViewOfIppoList") {
                    cell.segmentedControl.selectedSegmentIndex = selectedSegment == "達成済み" ? 0 : 1
                }
                return cell

            case .timeToStart:
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscCell", for: indexPath) as! MiscCell
                cell.iconImage.image = #imageLiteral(resourceName: "24Times")
                cell.titleLabel.text = "1日の開始時間"
                // UserDefaultsに記憶している設定を使用
                cell.detailLabel.text = userDefault.string(forKey: "timeToStart") ?? "0:00"
                return cell

            case .dayOfWeekToStart:
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscCell", for: indexPath) as! MiscCell
                cell.iconImage.image = #imageLiteral(resourceName: "DayOfWeekToStart")
                cell.titleLabel.text = "週の開始曜日"
                // UserDefaultsで記憶している曜日情報を取得
                let weekdayIndex = userDefault.integer(forKey: "dayOfWeekToStart")
                // 曜日表示用フォーマットを設定
                let formatter = DateFormatter()
                formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEE", options: 0, locale: Locale.autoupdatingCurrent)
                // 曜日を配列から取得
                let weekday = formatter.weekdaySymbols[weekdayIndex]
                cell.detailLabel.text = weekday
                return cell

            case .dateToStart:
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscCell", for: indexPath) as! MiscCell
                cell.iconImage.image = #imageLiteral(resourceName: "DateToStart")
                cell.titleLabel.text = "月の開始日"
                // UserDefaultsに記憶している設定を使用
                cell.detailLabel.text = userDefault.string(forKey: "dateToStart") ?? "1日"
                return cell
            }
            
        // MARK: AboutThisApp section
        case .aboutThisApp:
            
            guard let row = MiscVC.Section.AboutThisApp(rawValue: indexPath.row) else {
                fatalError("存在しない行を表示しようとしています")
            }
            
            switch row {
            case .reviewOnAppStore:
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscCell", for: indexPath) as! MiscCell
                cell.iconImage.image = #imageLiteral(resourceName: "StarOnBoard")
                cell.titleLabel.text = "AppStoreで評価する"
                cell.detailLabel.text = "❤️"
                cell.detailLabel.textColor = .orange
                return cell

            case .browseRepository:
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscCell", for: indexPath) as! MiscCell
                cell.iconImage.image = #imageLiteral(resourceName: "Github")
                cell.titleLabel.text = "開発リポジトリを見る"
                cell.detailLabel.text = nil
               return cell

            case .featureRequest:
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscCell", for: indexPath) as! MiscCell
                cell.iconImage.image = #imageLiteral(resourceName: "RequestService")
                cell.titleLabel.text = "機能のリクエスト"
                // UserDefaultsに記憶している機能リクエストの件数を使用
                cell.detailLabel.text = userDefault.string(forKey: "requestedFeatures")
                return cell

            case .bugReport:
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscCell", for: indexPath) as! MiscCell
                cell.iconImage.image = #imageLiteral(resourceName: "SmartphoneBug")
                cell.titleLabel.text = "不具合の報告"
                // UserDefaultsに記憶している報告済みのバグ件数を使用
                cell.detailLabel.text = userDefault.string(forKey: "reportedBugs")
                return cell

            case .AboutYasasiiKai:
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscCell", for: indexPath) as! MiscCell
                cell.iconImage.image = #imageLiteral(resourceName: "YasasiiKaiLogo")
                cell.titleLabel.text = "やさしい会について"
                cell.detailLabel.text = "詳しく知る"
                return cell
            }
        }
    }
}

// MARK: - TableView delegate
extension MiscVC: UITableViewDelegate {
    /// セルを選択した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択状態を解除
        tableView.deselectRow(at: indexPath, animated: true)

        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("存在しないセクション")
        }
        
        switch section {
        // MARK: Setting section
        case .setting:
            
            guard let row = Section.Setting(rawValue: indexPath.row) else {
                fatalError("存在しない行")
            }
            
            switch row {
            case .firstViewOfIppoList: break
            case .timeToStart:
                // TODO: 時間を設定する
                break
                
            case .dayOfWeekToStart:
                
                let cell = tableView.cellForRow(at: indexPath) as! MiscCell

                // 選択肢から選択してActionSheetが閉じ切ってからLabelの文字が変わるので一時的に非表示にしておく
                cell.detailLabel.isHidden = true
                let alert = UIAlertController(title: "何曜日からスタートしますか？",
                                              message: "期限を1週間とした時の基準となる曜日を選択してください",
                                              preferredStyle: .actionSheet)
                // 曜日を取得するためのフォーマット
                let df = DateFormatter()
                df.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEE", options: 0, locale: Locale.autoupdatingCurrent)
                // 曜日を配列から取得
                for (index, week) in df.weekdaySymbols.enumerated() {
                    alert.addAction(UIAlertAction(title: week, style: .default) { [weak self] _ in
                        // 選択した曜日を記憶
                        self?.userDefault.set(index, forKey: "dayOfWeekToStart")
                        cell.detailLabel.text = week
                        cell.detailLabel.isHidden = false
                    })
                }
                
                alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel){ _ in
                    cell.detailLabel.isHidden = false
                })
                
                self.present(alert, animated: true, completion: nil)
                
            case .dateToStart:
                // TODO: カレンダーから選択する？
                break
            }
            
        // MARK: AboutThisApp section
        case .aboutThisApp:
            
            guard let row = MiscVC.Section.AboutThisApp(rawValue: indexPath.row) else {
                fatalError("存在しない行")
            }
            
            switch row {
            case .reviewOnAppStore:
                // TODO: App Storeを表示する
                break
            case .browseRepository:
                // TODO: リポジトリをWKWebViewで表示する
                break
            case .featureRequest:
                
                let enhancementIssueVC = UIStoryboard(name: "EnhancementIssue", bundle: nil).instantiateInitialViewController() as! EnhancementIssueVC
                navigationController?.pushViewController(enhancementIssueVC, animated: true)

            case .bugReport:

                let bugIssueVC = UIStoryboard(name: "BugIssue", bundle: nil).instantiateInitialViewController() as! BugIssueVC
                navigationController?.pushViewController(bugIssueVC, animated: true)

            case .AboutYasasiiKai:
                // TODO: 詳細画面へ遷移する
                break
            }
        }
    }
}

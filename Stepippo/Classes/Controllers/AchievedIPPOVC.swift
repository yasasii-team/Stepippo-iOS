//
//  AchievedIPPOVC.swift
//  Stepippo
//
//  Created by Sab on 2019/5/25.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import UIKit
import RealmSwift
import XLPagerTabStrip

final class AchievedIPPOVC: UIViewController, RealmObjectAccessible {

    @IBOutlet private weak var tableView: UITableView!
    private var achievedIppoList: Results<IPPO>?
    
    // 先週の達成済みリスト
    private var achievedIppoListInLastWeek: Results<IPPO>? {
        // 週の初めの設定を取得
        let symbolIndexFromUd = UserDefaults.standard.integer(forKey: "dayOfWeekToStart")

        // 今週の開始日を計算
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = symbolIndexFromUd
        let startOfWeek = calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))!
        
        // 先週の開始日を計算
        let start = calendar.date(byAdding: .weekOfYear, value: -1, to: startOfWeek)!
        
        // 先週の開始日以降、今週の開始日より前で抽出
        let predicate = NSPredicate(format: "(performedDateTime >= %@) AND (performedDateTime < %@)", argumentArray: [start, startOfWeek])
        return achievedIppoList?.filter(predicate).sorted(byKeyPath: "performedDateTime", ascending: false)
    }
    
    // 今月の達成済みリスト
    private var achievedIppoListInCurrentMonth: Results<IPPO>? {
        // 月の開始日の設定を取得
        let referenceDateFromUd = UserDefaults.standard.string(forKey: "dateToStart") ?? "1"
        let monthLine = Int(referenceDateFromUd.trimmingCharacters(in: .letters))!
        
        // 今月の開始日を計算
        let currentMonth = Calendar.current.dateComponents([.year, .month], from: Date())
        let start = Calendar.current.date(from: DateComponents(year: currentMonth.year!, month: currentMonth.month!, day: monthLine))!
        
        // 来月の開始日を計算
        let end = Calendar.current.date(byAdding: .month, value: 1, to: start)!
        
        // 今月の開始日以降、来月の開始日より前で抽出
        let predicate = NSPredicate(format: "(performedDateTime >= %@) AND (performedDateTime < %@)", argumentArray: [start, end])
        return achievedIppoList?.filter(predicate).sorted(byKeyPath: "performedDateTime", ascending: false)
    }
    
    // 今年の達成済みリスト
    private var achievedIppoListInCurrentYear: Results<IPPO>? {
        let currentYear = Calendar.current.component(.year, from: Date())
        let comparison = Calendar.current.date(from: DateComponents(year: currentYear, month: 1, day: 1))!
        return achievedIppoList?.filter(NSPredicate(format: "performedDateTime >= %@", argumentArray:[comparison])).sorted(byKeyPath: "performedDateTime", ascending: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAchievedIppo()
        tableView.reloadData()
    }
    
    private func getAchievedIppo() {
        achievedIppoList = fetch(IPPO.self, predicate: NSPredicate(format: "_status = %@", argumentArray: [IPPOStatus.achieved.rawValue]))
        
    }
    
    private func getSelectedIppo(index: IndexPath) -> IPPO? {
        guard let sectionType = SectionType(rawValue: index.section) else { return nil }
        switch sectionType {
        case .lastWeek:
            return achievedIppoListInLastWeek?[index.row]
        case .currentMonth:
            return achievedIppoListInCurrentMonth?[index.row]
        case .currentYear:
            return achievedIppoListInCurrentYear?[index.row]
        }
    }
}

extension AchievedIPPOVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "達成済み"
    }
}

extension AchievedIPPOVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionType.allCases[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .lastWeek:
            return achievedIppoListInLastWeek?.count ?? 0
        case .currentMonth:
            return achievedIppoListInCurrentMonth?.count ?? 0
        case .currentYear:
            return achievedIppoListInCurrentYear?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let ippo = getSelectedIppo(index: indexPath) {
            cell.textLabel?.text = ippo.title
            cell.detailTextLabel?.text = ippo.performedDateTime?.toFormattedString()
        }
        
        return cell
    }
}

extension AchievedIPPOVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            guard let realm = try? Realm() else { print("Realmインスタンスの生成に失敗"); return }
            try? realm.write { [weak self] in
                if let ippo = self?.getSelectedIppo(index: indexPath) {
                    realm.delete(ippo)
                    tableView.reloadData()
                    completion(true)
                }
            }
            completion(false)
        }
        let stockAction = UIContextualAction(style: .normal, title: "Stock") { (_, _, completion) in
            guard let realm = try? Realm() else { print("Realmインスタンスの生成に失敗"); return }
            try? realm.write { [weak self] in
                self?.getSelectedIppo(index: indexPath)?.status = IPPOStatus.stock
                tableView.reloadData()
                completion(true)
            }
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, stockAction])
    }
}

private enum SectionType: Int, CaseIterable {
    case lastWeek = 0
    case currentMonth
    case currentYear
    
    var title: String {
        switch self {
        case .lastWeek:
            return "先週"
        case .currentMonth:
            return "今月"
        case .currentYear:
            return "今年"
        }
    }
}

// TODO: 別ファイルにして設定画面と共通化
enum WeekDay: String, CaseIterable {
    case sun = "日曜日"
    case mon = "月曜日"
    case tue = "火曜日"
    case wed = "水曜日"
    case thu = "木曜日"
    case fri = "金曜日"
    case sat = "土曜日"
    
    var toGregorian: String {
        switch self {
        case .sun:
            return "Sun"
        case .mon:
            return "Mon"
        case .tue:
            return "Tue"
        case .wed:
            return "Wed"
        case .thu:
            return "Thu"
        case .fri:
            return "Fri"
        case .sat:
            return "Sat"
        }
    }
}

import UIKit
import RealmSwift
import XLPagerTabStrip

final class StockedIPPOVC: UIViewController, RealmObjectAccessible {

    // TODO: リストのセクション分け
    private var stockedIppoList: Results<IPPO>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStockedIppo()
    }
    
    private func getStockedIppo() {
        stockedIppoList = fetch(IPPO.self).filter(NSPredicate(format: "_status = %@", argumentArray: [IPPOStatus.stock.rawValue]))
    }
}

extension StockedIPPOVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "ストック"
    }
}

extension StockedIPPOVC: UITableViewDataSource {
    // TODO: セクション分けとセクションヘッダーの表示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockedIppoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SECTION HEADING"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let ippo = stockedIppoList?[indexPath.row] {
            cell.textLabel?.text = ippo.title
            cell.detailTextLabel?.text = ippo.addDateTime.toFormattedString()
        }
        
        return cell
    }
}

extension StockedIPPOVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            guard let realm = try? Realm() else { print("Realmインスタンスの生成に失敗"); return }
            try? realm.write { [weak self] in
                if let ippo = self?.stockedIppoList?[indexPath.row] {
                    realm.delete(ippo)
                    tableView.reloadData()
                    completion(true)
                }
            }
            completion(false)
        }
        let doneAction = UIContextualAction(style: .normal, title: "Done") { (_, _, completion) in
            guard let realm = try? Realm() else { print("Realmインスタンスの生成に失敗"); return }
            try? realm.write { [weak self] in
                self?.stockedIppoList?[indexPath.row]._status = IPPOStatus.achieved.rawValue
                tableView.reloadData()
                completion(true)
            }
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, doneAction])
    }
}

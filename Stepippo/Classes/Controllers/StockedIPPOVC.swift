import UIKit
import RealmSwift
import XLPagerTabStrip

final class StockedIPPOVC: UIViewController, IPPORepository {

    private var stockedIppoList: Results<IPPO>?
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getStockedIppo()
        tableView.reloadData()
    }
    
    private func getStockedIppo() {
        stockedIppoList = fetch(predicate: NSPredicate(format: "_status = %@", argumentArray: [IPPOStatus.stock.rawValue]), sortKeyPath: "addDateTime", isAcsending: false)
    }
}

extension StockedIPPOVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "ストック"
    }
}

extension StockedIPPOVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockedIppoList?.count ?? 0
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
                if let ippo = self?.stockedIppoList?[indexPath.row] {
                    ippo.status = .achieved
                    ippo.performedDateTime = Date()
                }
                tableView.reloadData()
                completion(true)
            }
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, doneAction])
    }
}

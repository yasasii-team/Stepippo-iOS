import UIKit
import RealmSwift

final class StockedIPPOVC: UIViewController {

    private var stockedIppoList: Results<IPPO>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStockedIppo()
    }
    
    private func getStockedIppo() {
        guard let realm = try? Realm() else { print("Realmインスタンスの生成に失敗"); return }
        stockedIppoList = realm.objects(IPPO.self).filter(NSPredicate(format: "_status = %@", argumentArray: [IPPOStatus.stock.rawValue]))
    }
}

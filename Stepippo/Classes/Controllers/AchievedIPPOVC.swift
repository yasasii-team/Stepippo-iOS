import UIKit
import RealmSwift

final class AchievedIPPOVC: UIViewController {

    private var achievedIppoList: Results<IPPO>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAchievedIppo()
    }
    
    private func getAchievedIppo() {
        guard let realm = try? Realm() else { print("Realmインスタンスの生成に失敗"); return }
        achievedIppoList = realm.objects(IPPO.self).filter(NSPredicate(format: "_status = %@", argumentArray: [IPPOStatus.achieved.rawValue]))
    }
}

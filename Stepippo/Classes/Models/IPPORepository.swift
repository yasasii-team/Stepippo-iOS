//
//  IPPORepository.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/05/11.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import Foundation
import RealmSwift

/// Realmオブジェクトを操作するためのプロトコル
protocol IPPORepository {}

// MARK: - RealmObjectAccessor Extension
extension IPPORepository {
    
    // MARK: - 書き込み
    
    /// 新しいRealmオブジェクトを追加する。すでに存在するプライマリーキーであれば更新する
    ///
    /// - Parameters:
    ///   - object: 追加するRealmオブジェクト
    ///   - isUpdate: すでに存在するプライマリーキーを指定していた場合に更新するか否か
    func write(_ ippo: IPPO, isUpdate: Bool = true) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(ippo, update: isUpdate)
        }
    }
    
    /// プライマリーキーで指定したRealmオブジェクト一部分を更新する
    ///
    /// - Parameters:
    ///   - primaryKey: 一意のID
    ///   - values: 更新したいサブセット
    ///   - isUpdate: すでにあるプライマリーキーだった場合、更新するか否か。デフォルトは更新する
    func update(with primaryKey: String, values: [String: Any], isUpdate: Bool = true) {
        
        let realm = try! Realm()
        
        try! realm.write {
            for (key, value) in values {
                realm.create(Object.self, value: ["id": primaryKey, key: value], update: isUpdate)
            }
        }
    }
    
    // MARK: - 読み込み
    
    /// 検索条件でフィルタリングしたRealmオブジェクトの検索結果を返す
    ///
    /// - Parameters:
    ///   - objectType: Realmオブジェクトの型
    ///   - predicate: 検索条件
    /// - Returns: 検索結果のRealmオブジェクト
    func fetch(predicate: NSPredicate? = nil) -> Results<IPPO> {
        
        let realm = try! Realm()

        if let predicate = predicate {
            return realm.objects(IPPO.self).filter(predicate)
        }
        return realm.objects(IPPO.self)
    }
    
    /// フィルタリング検索し、並び替えをしたRealmオブジェクト結果を返す
    ///
    /// - Parameters:
    ///   - objectType: Realmオブジェクトの型
    ///   - predicate: 検索条件
    ///   - sortKeyPath: 並び替えに使うkey
    ///   - isAcsending: 昇順か否か。デフォルトは昇順
    /// - Returns: 検索結果のRealmオブジェクト
    func fetch(predicate: NSPredicate?, sortKeyPath: String, isAcsending: Bool = true) -> Results<IPPO> {
        // predicateが指定されていればけフィルタリングを行う
        if let predicate = predicate {
            return fetch(predicate: predicate).sorted(byKeyPath: sortKeyPath, ascending: isAcsending)
        }
        
        let realm = try! Realm()

        return realm.objects(IPPO.self).sorted(byKeyPath: sortKeyPath, ascending: isAcsending)
    }
    
    // MARK: - 削除
    
    /// 渡されたRealmオブジェクトを削除する
    ///
    /// - Parameter object: Realm Model Object
    func delete(ippo: IPPO) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(ippo)
        }
    }
    
    /// Realmオブジェクトを全削除する。スペースを効率的に再利用するためにディスク上でそのサイズを維持する
    func deleteAll() {
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}

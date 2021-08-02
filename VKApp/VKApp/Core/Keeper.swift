//
//  Keeper.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 22.07.2021.
//

import Foundation
import Unrealm
import RealmSwift

final class Keeper {
    static func saveData<T: Realmable>(_ data: [T]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(data, update: true)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func getUserFromBase(_ pk: Int) -> Friend?{
        let realm = try! Realm()
        return realm.object(ofType: Friend.self, forPrimaryKey: pk)
    }
    
    static func getGroupFromBase(_ pk: Int) -> MyGroup?{
        let realm = try! Realm()
        return realm.object(ofType: MyGroup.self, forPrimaryKey: pk)
    }
    
    static func loadData<T>(_ typeReceiver: T.Type) -> Unrealm.Results<T> where T:Realmable {
        let realm = try! Realm()
        return realm.objects(T.self)
    }
}

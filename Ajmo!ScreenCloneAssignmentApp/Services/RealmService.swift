//
//  Realm.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 25/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func save<T: Object>(_ object : T){
        do {
            try realm.write{
                realm.add(object, update: .modified)
            }
        } catch  {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T){
        do {
            try realm.write{
                realm.delete(object)
            }
        } catch  {
            print(error)
        }
    }
    
    func post(_ error : Error){
        NotificationCenter.default.post(name: NSNotification.Name("Realm error"), object: error)
    }
    
    func observeForRealmErrors(in vc : UIViewController, completion: @escaping (Error?) -> Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Realm error"), object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrorsForRealm(in vc : UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("Realm error"), object: nil)
    }
    
    func saveItemEntity(_ data: DataGettable){
        let item = Item()
        item.id = data.id
        item.title = data.title
        item.caption = data.caption
        item.linkType = data.linkType
        item.createdAt = data.createdAt
        item.imageURL = data.imageURL
        item.datumDescription = data.datumDescription
        item.isHighlighted = data.isHighlighted
        item.picture = data.picture
        
        RealmService.shared.save(item)
        
    }
}

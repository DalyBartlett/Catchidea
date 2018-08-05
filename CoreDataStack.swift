//
//  CoreDataStack.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/18.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit
import CoreData

internal class CoreDataStack {
    
    @available(iOS 10.0, *)
    static var persistentContainer: NSPersistentContainer = {
        let container = SharedPersistentContainer(name: "CatchIdea")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
}

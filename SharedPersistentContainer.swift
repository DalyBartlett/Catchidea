//
//  SharedPersistentContainer.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/18.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class SharedPersistentContainer: NSPersistentContainer {

    override static func defaultDirectoryURL()-> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.classifyidea.app")!
    }
}

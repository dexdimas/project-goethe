//
//  CoreDataHelper.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 16/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataHelper {
    var context: NSManagedObjectContext
    
    func fetchAll<T: NSManagedObject>() -> [T] {
        let request = T.fetchRequest()
        do {
            return try context.fetch(request) as? [T] ?? []
        } catch {
            return []
        }
    }
}

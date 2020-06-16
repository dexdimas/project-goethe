//
//  UIViewController+Extensions.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 16/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
}

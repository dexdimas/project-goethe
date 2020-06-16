//
//  Color+Extensions.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 16/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import UIKit
import CoreData

extension Color {
    
    static func saveTask(context: NSManagedObjectContext, colorName: String, colorHex: String, colorRed: Float, colorGreen: Float, colorBlue: Float) -> Color? {
        let color = Color(context: context)
        color.colorName = colorName
        color.colorHex = colorHex
        color.colorRed = colorRed
        color.colorGreen = colorGreen
        color.colorBlue = colorBlue
        do {
            try context.save()
            return color
        } catch {
            return nil
        }
    }
    
    static func fetchAll(context: NSManagedObjectContext) -> [Color] {
        let request: NSFetchRequest<Color> = Color.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
}

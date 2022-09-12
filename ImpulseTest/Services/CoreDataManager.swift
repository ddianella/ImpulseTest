//
//  CoreDataService.swift
//  ImpulseTest
//
//  Created by Diana on 11.09.2022.
//

import UIKit
import CoreData

class CoreDataManager {
    var timerScreenWasShown = false
    private let boolKey =  "timerWasShown"
    private let entityName = "ShowingTimer"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getData() -> Bool{
//        var timerScreenWasShown = Bool()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                timerScreenWasShown = data.value(forKey: boolKey) as! Bool
            }
        } catch let error as NSError {
            print("Failed: \(error.localizedDescription)")
        }
        return timerScreenWasShown
    }
    
    func saveData(timerScreenWasShown: Bool) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return }
        let newEntity = NSManagedObject(entity: entity, insertInto: context)
        newEntity.setValue(timerScreenWasShown, forKey: boolKey)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed: \(error.localizedDescription)")
        }
    }
}

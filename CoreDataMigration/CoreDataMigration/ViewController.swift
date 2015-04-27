//
//  ViewController.swift
//  CoreDataMigration
//
//  Created by Maroof Khan on 4/27/15.
//  Copyright (c) 2015 Maroof Khan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var context: NSManagedObjectContext? {
        let _appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let _context = _appDelegate.managedObjectContext
        return _context
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = NSManagedObject(entity: Person.entity!, insertIntoManagedObjectContext: context!) as Person
        person.firstName = "First"
        person.lastName = "Last"
        person.age = Int16(28)
        person.isMale = true
        var error: NSError?
        context!.save(&error)
        if let _error = error {
            println("\(_error.localizedDescription)")
        } else {
            println("Success!")
        }
        
        var fetchError: NSError?
        let fetchRequest = NSFetchRequest(entityName: "\(Person.name)")
        let results = context!.executeFetchRequest(fetchRequest, error: &fetchError) as [Person]
        if let _error = fetchError {
            println("\(_error.localizedDescription)")
        } else {
            for person in results {
                println("***************")
                println(person.firstName)
                println(person.lastName)
                println(person.age)
                println(person.isMale)
            }
        }
        
    }


}


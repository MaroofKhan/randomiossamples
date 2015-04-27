//
//  Person.swift
//  CoreDataMigration
//
//  Created by Maroof Khan on 4/27/15.
//  Copyright (c) 2015 Maroof Khan. All rights reserved.
//

import Foundation
import CoreData

@objc (Person)
class Person: NSManagedObject {
    
    class var name: String {
        return Person.classForCoder().description()
    }
    
    class var entity: NSEntityDescription? {
        let _entity = NSEntityDescription.entityForName("\(Person.name)", inManagedObjectContext: context!)
        return _entity
    }

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var age: Int16
    @NSManaged var isMale: Bool

}

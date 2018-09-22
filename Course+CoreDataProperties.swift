//
//  Course+CoreDataProperties.swift
//  gpa-calculator
//
//  Created by Student on 20/05/18.
//  Copyright © 2018 Student. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Course {

    @NSManaged var courseName: String?
    @NSManaged var courseCredit: String?
    @NSManaged var courseGrade: String?
    @NSManaged var courseDescription: String?

}

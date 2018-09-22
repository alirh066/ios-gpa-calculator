//
//  Course.swift
//  gpa-calculator
//
//  Created by Student on 19/05/18.
//  Copyright © 2018 Student. All rights reserved.
//


import UIKit

class myCourse{
    var name: String = ""
    var credit: Int = 0
    var grade = ""
    var description = "No available description"
    
    init(name:String,credit:Int){
        self.name = name
        self.credit = credit
    }
}

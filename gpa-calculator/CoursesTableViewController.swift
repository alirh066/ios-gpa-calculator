//
//  CoursesTableViewController.swift
//  gpa-calculator
//
//  Created by Student on 19/05/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController {

    @IBAction func onRemove(sender: UIButton) {
        removeSelected()
    }
    

    
    @IBAction func onCalculate(sender: UIButton) {
        let result = Double(round(calc()*100)/100)
        let alert = UIAlertController(title: "Result", message: "Your GPA is \(result)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
 
    var courses:[myCourse] = []

    override func viewDidLoad() {  
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if courses.count == 0{
                return 1
            }
            else{
            return courses.count
            }
        }
        else{
            return 1
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("course", forIndexPath: indexPath) as! courseCell
            
            if courses.count == 0{
                cell.textLabel?.text = "Choose courses from catalog tab."
                cell.lblName.text = ""
            }
            
            else{
            let course = courses[indexPath.row]
            cell.lblName.text = course.name
            cell.lblCredit.text = String(course.credit)
            cell.state.setOn(false, animated: false)
            cell.tfGrade.text = course.grade
            }
            
            return cell
        }
            
            
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("buttons", forIndexPath: indexPath) as! buttonsCell
            
            
            return cell
        }
    }
    
    
    func calc() -> Double{
        courses.removeAll()
        let limit = tableView.numberOfRowsInSection(0)
        var credits = 0
        var grade = 0.0
        for i in 0..<limit {
            
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! courseCell
            let credit = Int(cell.lblCredit.text!)!
            let name = cell.lblName.text
            let txtGrade = cell.tfGrade.text!
            credits += credit
            
            let trimmedGrade = txtGrade.uppercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            grade += Double(credit) * toNumericGrade(trimmedGrade)
            
            let newCourse = myCourse(name: name!, credit: credit)
            newCourse.grade = txtGrade
            
            courses.append(newCourse)
            
        }
        return grade/Double(credits)
    }
    
    func updateCourses(){
        courses.removeAll()
        let limit = tableView.numberOfRowsInSection(0)
        for i in 0..<limit {
            
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! courseCell
            let credit = Int(cell.lblCredit.text!)!
            let name = cell.lblName.text
            let txtGrade = cell.tfGrade.text!
            let newCourse = myCourse(name: name!, credit: credit)
            newCourse.grade = txtGrade
            
            courses.append(newCourse)
            
        }
    }
    
    func toNumericGrade(grade:String) -> Double {
        if grade == "A"{
            return 4.0
        }
        else if grade == "A-"{
            return 3.7
        }
        else if grade == "B+"{
            return 3.3
        }else if grade == "B"{
            return 3.0
        }else if grade == "B-"{
            return 2.7
        }else if grade == "C+"{
            return 2.3
        }else if grade == "C"{
            return 2.0
        }else if grade == "C-"{
            return 1.7
        }else if grade == "D+"{
            return 1.3
        }else if grade == "D"{
            return 1.0
        }
        return 0.0
    }
    
    func addCourse(c:myCourse){
        
        if !isExist(c){
            
            courses.append(c)
            tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        }
    }
    
    func isExist(course:myCourse) -> Bool{
        for i in courses{
            if course.name == i.name {
                return true
            }
        }
        return false
    }
    
    func removeSelected(){
 
        var indeces:[Int] = []
        
        for i in 0..<courses.count {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! courseCell
            if cell.state.on {
                indeces.append(i)
            }
        }
        
        for i in indeces.reverse(){
            courses.removeAtIndex(i)
        }
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
}

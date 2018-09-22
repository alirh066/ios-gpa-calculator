//
//  CatalogTableViewController.swift
//  gpa-calculator
//
//  Created by Student on 19/05/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreData

class CatalogTableViewController: UITableViewController {

    @IBAction func onRemoveSelected(sender: UIButton) {
        removeSelected()
    }
    
    @IBAction func onAddSelected(sender: UIButton) {
        addToCourses()
    }

    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    var coursesController : CoursesTableViewController?
    var courses:[myCourse] = []
    var dataLine :[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursesController = self.tabBarController?.viewControllers?.first as? CoursesTableViewController
        read()
    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return courses.count
        }
        else{
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 80.0
        }
        else {
            return 50.0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("catalog", forIndexPath: indexPath) as! catalogCell
            
            let course = courses[indexPath.row]
            cell.lblName.text = course.name
            cell.lblCredit.text = String(course.credit)
            cell.lblDescription.text = course.description
            cell.state.setOn(false, animated: false)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("catalogButtonsCell", forIndexPath: indexPath) as! catalogButtonsCell
            
            
            return cell
        }
    }
    
    func addToCourses(){
        let limit = tableView.numberOfRowsInSection(0)
        for i in 0..<limit {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! catalogCell
            if cell.state.on {
                let name = cell.lblName.text!
                let credit = Int(cell.lblCredit.text!)!
                
                let course = myCourse(name: name, credit: credit)
                
                coursesController?.addCourse(course)
                
            }
        }
    }
    
    func removeSelected(){
        var indeces:[Int] = []
        for i in 0..<courses.count {
            
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! catalogCell
            if cell.state.on {
                indeces.append(i)
            }
        }
        for i in indeces.reverse(){
            let o = courses[i]
            courses.removeAtIndex(i)
            let request = NSFetchRequest(entityName: "Course")
            do {
                let list = try moc.executeFetchRequest(request)
                for i in list{
                    let name = String(i.valueForKey("courseName")!)
                    if name == o.name {
                        moc.deleteObject(i as! NSManagedObject)
                        do{
                            try moc.save()
                            }
                        catch  {
                          print("error while saving...")
                            }
                    }
                }
            } catch let error as NSError {
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? ViewController {
            destinationViewController.catalogControler = self
            
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
    
    
    func addCourse(c:myCourse){
        
        if !isExist(c){
            courses.append(c)
            saveCourse(c)
            tableView.reloadData()
            
        }
    }
    

    func saveCourse(course:myCourse){
        let ed  = NSEntityDescription.entityForName("Course", inManagedObjectContext: moc)
        let data = Course(entity: ed!, insertIntoManagedObjectContext: moc)
        data.courseName = course.name
        data.courseCredit = String(course.credit)
        data.courseDescription = course.description
        do{
            try moc.save()
        }
        catch  {
            print("error while saving...")
        }
    }

    func read(){
        let request = NSFetchRequest(entityName: "Course")
        do {
            let list = try moc.executeFetchRequest(request)
            for i in list{
                let name = String(i.valueForKey("courseName")!)
                let credit = Int(String(i.valueForKey("courseCredit")!))!
                let desc = String(i.valueForKey("courseDescription")!)
                let course = myCourse(name: name, credit: credit)
                course.description = desc
                courses.append(course)
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
}

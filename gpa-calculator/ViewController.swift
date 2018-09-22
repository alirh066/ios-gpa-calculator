//
//  ViewController.swift
//  gpa-calculator
//
//  Created by Student on 19/05/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var catalogControler: CatalogTableViewController?
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtDescritption: UITextField!
   
    @IBOutlet weak var txtCredit: UITextField!

    @IBAction func onSubmit(sender: UIButton) {
        catalogControler?.addCourse(getCourse())
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func getCourse() -> myCourse{
        let name = txtName.text!
        let credit = Int(txtCredit.text!)!
        let description = txtDescritption.text!
        let course = myCourse(name: name, credit: credit)
        course.description = description
        return course
    }


}


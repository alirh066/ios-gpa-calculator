//
//  catalogButtonsCell.swift
//  gpa-calculator
//
//  Created by Student on 19/05/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class catalogButtonsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var btnAddNewCourse: UIButton!
    @IBOutlet weak var btnRemoveSelected: UIButton!
    @IBOutlet weak var btnAddSelected: UIButton!

   
}

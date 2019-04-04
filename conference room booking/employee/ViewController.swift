//
//  ViewController.swift
//  conference room booking
//
//  Created by XIPHIAS Softwares on 27/03/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var EmpoyeeButton: UIButton!
    @IBOutlet weak var AdminButton: UIButton!
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
      
        
        
        
      // sizes of the data
        EmpoyeeButton.layer.cornerRadius = 15
        EmpoyeeButton.setTitleColor(EmpoyeeButton.titleLabel?.textColor, for: .normal)
        
        AdminButton.layer.cornerRadius = 15
        AdminButton.setTitleColor(AdminButton.titleLabel?.textColor, for: .normal)
        
    
    }


}


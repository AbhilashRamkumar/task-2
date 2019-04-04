//
//  BookRegViewController.swift
//  conference room booking
//
//  Created by Admin on 01/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit

class BookRegViewController: UIViewController {
  
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var BookingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        RegisterButton.layer.cornerRadius = 15
        RegisterButton.setTitleColor(RegisterButton.titleLabel?.textColor, for: .normal)
        
        
        
        BookingButton.layer.cornerRadius = 15
        BookingButton.setTitleColor(BookingButton.titleLabel?.textColor, for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

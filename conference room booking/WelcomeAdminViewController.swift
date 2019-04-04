//
//  WelcomeAdminViewController.swift
//  conference room booking
//
//  Created by Admin on 02/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit

class WelcomeAdminViewController: UIViewController {
    @IBOutlet weak var registerPressed: UIButton!
    @IBOutlet weak var bookingPressed: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        registerPressed.layer.cornerRadius = 15
        
        
        bookingPressed.layer.cornerRadius = 15
       
        
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

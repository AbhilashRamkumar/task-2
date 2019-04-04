//
//  BookingViewController.swift
//  conference room booking
//
//  Created by Admin on 02/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BookingViewController: UIViewController, UITextFieldDelegate {

    
    
    var dateAndTme = [String]()
    
    
    
    
    @IBOutlet weak var dateAndTimeTextfield: UITextField!
    @IBOutlet weak var TimeTextField: UITextField!
    @IBOutlet weak var ConferenceHallTextfield: UITextField!
    
    @IBOutlet weak var checkPressed: UIButton!
    @IBOutlet weak var bookPressed: UIButton!
    @IBOutlet weak var commentsTextfield: UITextField!
    

    
    
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    
    let  dateAndTime =  dateAndTimeTextfield
    
    
    
    
    
    self.dateAndTimeTextfield.delegate = self
    self.TimeTextField.delegate = self
    
    self.ConferenceHallTextfield.delegate = self
    self.commentsTextfield.delegate = self
    
    
    DispatchQueue.main.async {
        self.dateAndTimeTextfield.layer.cornerRadius = 20
        self.TimeTextField.layer.cornerRadius = 20
        self.ConferenceHallTextfield.layer.cornerRadius = 20
        self.commentsTextfield.layer.cornerRadius = 20
        self.checkPressed.layer.cornerRadius = 20
        self.bookPressed.layer.cornerRadius = 20
        
    }
    
    dateAndTimeTextfield.addPadding(.both(20))
    TimeTextField.addPadding(.both(20))
    ConferenceHallTextfield.addPadding(.both(20))
    commentsTextfield.addPadding(.both(20))
  
        }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



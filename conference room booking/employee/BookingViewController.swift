//
//  BookingViewController.swift
//  conference room booking
//
//  Created by Admin on 02/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class BookingViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
   
    

    
    
    var dateAndTme = [String]()
    
    
    
    @IBOutlet weak var NameTextfield: UITextField!
    
    @IBOutlet weak var dateAndTimeTextfield: UITextField!
    @IBOutlet weak var TimeTextField: UITextField!
    @IBOutlet weak var ConferenceHallTextfield: UITextField!
    
    @IBOutlet weak var checkPressed: UIButton!
    @IBOutlet weak var bookPressed: UIButton!
    @IBOutlet weak var commentsTextfield: UITextField!
    

    var data = ["Conference hall 1","Conference hall 2","Conference hall 3"]
    var picker = UIPickerView()
    
    
    
    let datePicker = UIDatePicker()
    
    let starttimedatePicker = UIDatePicker()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    
    // for Date picker
    datePicker.datePickerMode = UIDatePicker.Mode.date
    
    dateAndTimeTextfield.inputView = datePicker
    
    datePicker.addTarget(self, action: #selector(datePickerFromValueChanged), for: UIControl.Event.valueChanged)
    
    // Time picker
    TimeTextField.inputView = starttimedatePicker
        starttimedatePicker.addTarget(self, action: #selector(startTimeDiveChanged), for: .valueChanged)
    

        
        
    // picker for conference hall
        picker.delegate = self
        picker.dataSource = self
        ConferenceHallTextfield.inputView = picker
    

        
        
    
    
    
    self.dateAndTimeTextfield.delegate = self
    self.TimeTextField.delegate = self
    
    self.ConferenceHallTextfield.delegate = self
    self.commentsTextfield.delegate = self
    
    self.NameTextfield.delegate = self
    
        
    
    DispatchQueue.main.async {
        self.dateAndTimeTextfield.layer.cornerRadius = 20
        self.TimeTextField.layer.cornerRadius = 20
        self.ConferenceHallTextfield.layer.cornerRadius = 20
        self.commentsTextfield.layer.cornerRadius = 20
        self.checkPressed.layer.cornerRadius = 20
        self.bookPressed.layer.cornerRadius = 20
        self.NameTextfield.layer.cornerRadius = 20
    }
    
    dateAndTimeTextfield.addPadding(.both(20))
    TimeTextField.addPadding(.both(20))
    ConferenceHallTextfield.addPadding(.both(20))
    commentsTextfield.addPadding(.both(20))
    NameTextfield.addPadding(.both(20))
        }
    
   // function for textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // function for date picker
    @objc func datePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateAndTimeTextfield.text = dateFormatter.string(from: sender.date)
        
    }
    // function for time picker
      @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        timeFormatter.dateFormat = "hh:mm:ss a"
        TimeTextField.text = timeFormatter.string(from: sender.date)
        
    }
    
    // for conference hall
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ConferenceHallTextfield.text = data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    // for comments section
    
  
    
    
    
    
    @IBAction func checkPressed(_ sender: UIButton) {
        
        
        
        
        guard let name = NameTextfield.text, let date = dateAndTimeTextfield.text, let time = TimeTextField.text,
            let hall = ConferenceHallTextfield.text else {
                print("Please provide a value for the previous textfields")
                return
        }
        
        print("Starting call to firebase")
        
        let ref = Database.database().reference()
        
        guard let user = Auth.auth().currentUser else {
            print("User  not authenticated")
            return
        }
        
        let myData: [String: String] = [
            "name": name,
            "date": date,
            "time": time,
            "conference-hall": hall
        ]
        
        ref.child("bookings").child(user.uid).setValue(myData) { (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            }
            else {
                print("Data saved successfully!")
            }
        
        
        // Retrieving fo data

            ref.child("bookings").observe(.childAdded, with: { (snapshot) in
                
                _ = [DataSnapshot]()
                
                for item in snapshot.children {
                    
                    if ((item as! DataSnapshot).value as? String) != nil {
                        // might want to do another loop if you have an array of places to check
                        
                        if snapshot.value as? String == "myData" {
                            // this is what you want
                        }
                        
                    }
                    
                }
            })
    }
    }




    

    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


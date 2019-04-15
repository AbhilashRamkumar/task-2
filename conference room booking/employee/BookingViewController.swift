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
import IQKeyboardManagerSwift

class BookingViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
   
    var dateAndTme = [String]()

    @IBOutlet weak var NameTextfield: UITextField!
    @IBOutlet weak var dateAndTimeTextfield: UITextField!
    @IBOutlet weak var StartTimeTextField: UITextField!
    @IBOutlet weak var EndTimeTextField: UITextField!
    @IBOutlet weak var ConferenceHallTextfield: UITextField!
    @IBOutlet weak var checkPressed: UIButton!
    @IBOutlet weak var bookPressed: UIButton!
    @IBOutlet weak var commentsTextfield: UITextField!
    
    
    
    var data = ["Conference hall 1","Conference hall 2","Conference hall 3"]
    var picker = UIPickerView()
    
    let datePicker = UIDatePicker()
    let starttimedatePicker = UIDatePicker()
    let endtimedatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    // for Date picker
    datePicker.datePickerMode = UIDatePicker.Mode.date
    dateAndTimeTextfield.inputView = datePicker
    datePicker.addTarget(self, action: #selector(datePickerFromValueChanged), for: UIControl.Event.valueChanged)
    
    // Start Time picker
    starttimedatePicker.datePickerMode = UIDatePicker.Mode.time
    StartTimeTextField.inputView = starttimedatePicker
    starttimedatePicker.addTarget(self, action: #selector(startTimeDateChanged), for: .valueChanged)
    
    // End Time Picker
    endtimedatePicker.datePickerMode = UIDatePicker.Mode.time
    EndTimeTextField.inputView = endtimedatePicker
    endtimedatePicker.addTarget(self, action: #selector(endTimeDateChanged), for: .valueChanged)
        
    // picker for conference hall
    picker.delegate = self
    picker.dataSource = self
    ConferenceHallTextfield.inputView = picker

        self.dateAndTimeTextfield.delegate = self
        self.StartTimeTextField.delegate = self
        self.EndTimeTextField.delegate = self
        self.ConferenceHallTextfield.delegate = self
        self.commentsTextfield.delegate = self
        self.NameTextfield.delegate = self
    DispatchQueue.main.async {
        self.dateAndTimeTextfield.layer.cornerRadius = 20
        self.StartTimeTextField.layer.cornerRadius = 20
        self.EndTimeTextField.layer.cornerRadius = 20
        self.ConferenceHallTextfield.layer.cornerRadius = 20
        self.commentsTextfield.layer.cornerRadius = 20
        self.checkPressed.layer.cornerRadius = 20
        self.bookPressed.layer.cornerRadius = 20
        self.NameTextfield.layer.cornerRadius = 20
    }
    dateAndTimeTextfield.addPadding(.both(20))
    StartTimeTextField.addPadding(.both(20))
    EndTimeTextField.addPadding(.both(20))
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
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateAndTimeTextfield.text = dateFormatter.string(from: sender.date)
        
    }
    // function for time picker
      @objc func startTimeDateChanged(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
     
        timeFormatter.dateFormat = "h:mm a"
        StartTimeTextField.text = timeFormatter.string(from: sender.date)
    }
    // function for end time picker
    @objc func endTimeDateChanged(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
     
        timeFormatter.dateFormat = "h:mm a"
        EndTimeTextField.text = timeFormatter.string(from: sender.date)
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
    
  
    
    
    
    
    
        
        
    @IBAction func bookPressed(_ sender: Any) {
        
        
        
        
        guard let name = NameTextfield.text, let date = dateAndTimeTextfield.text, let fromTime = StartTimeTextField.text, let toTime = EndTimeTextField.text, let hall = ConferenceHallTextfield.text else {
            print("Please provide a value for the previous textfields")
            return
        }
        
        let myData: [String: String] = [
            "name": name,
            "date": date,
            "StartTime": fromTime,
            "EndTime": toTime,
            "conferenceHall": hall
        ]
        
        Database.database().reference(withPath: "booking").queryEqual(toValue: date).observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot.children.allObjects.count)
            if snapshot.children.allObjects.count == 0{
                //Saving fo data
                self.saveData(myData)
                self.commentsTextfield.text = "Available"
            }
            else{
                var bookedStatus = false
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
                timeFormatter.timeZone = NSTimeZone.local
                let LSTime = timeFormatter.date(from: date+" "+fromTime)
                let LETime = timeFormatter.date(from: date+" "+toTime)
                print(LSTime!,LETime!)
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    if let data : [String:Any] = snap.value as? [String:Any]{
                        print(data)
                        if let name : String = data["name"] as? String,let date : String = data["date"] as? String,let time1 : String = data["StartTime"] as? String, let time2 : String = data["EndTime"] as? String, let confinRoomNo : String = data["conferenceHall"] as? String{
                            print(name,date,time1,time2,confinRoomNo)
                            
                            let FSTime = timeFormatter.date(from: date+" "+time1)
                            let FETime = timeFormatter.date(from: date+" "+time2)
                            print(FSTime!,FETime!)
                            if  FSTime!.equalToDate(dateToCompare:LSTime!) ||
                                FSTime!.equalToDate(dateToCompare: LETime!) ||
                                FETime!.equalToDate(dateToCompare:LSTime!) ||
                                FETime!.equalToDate(dateToCompare: LETime!) ||
                                (FSTime!.isGreaterThanDate(dateToCompare: LSTime!) && FSTime!.isLessThanDate(dateToCompare: LETime!)) ||
                                (FETime!.isGreaterThanDate(dateToCompare: LSTime!) && FETime!.isLessThanDate(dateToCompare: LETime!)){
                                print("Room not avaiable")
                                bookedStatus = true
                                break
                            }
                            else{
                                print("Avaiable")
                            }
                        }
                    }
                }
                if !bookedStatus{
                    self.saveData(myData)
                }
            }
        })
    }
    
    
    
    func saveData(_ data: [String:String]){
        let messagesDB = Database.database().reference().child("booking")
        messagesDB.childByAutoId().setValue(data) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            }
            else {
                print("Message saved successfully!")
            }
        }
    }

    
   
    
    
    @IBAction func checkPressed(_ sender: Any) {
        
        guard let name = NameTextfield.text, let date = dateAndTimeTextfield.text, let fromTime = StartTimeTextField.text, let toTime = EndTimeTextField.text, let hall = ConferenceHallTextfield.text else {
            print("Please provide a value for the previous textfields")
            return
        }
        
        print("Starting call to firebase")
        
        var ref = Database.database().reference()
        
        guard let user = Auth.auth().currentUser else {
            print("User  not authenticated")
            return
        }
        
        
        
        let myData: [String: String] = [
            "name": name,
            "date": date,
            "StartTime": fromTime,
            "EndTime": toTime,
            "conferenceHall": hall
        ]
        
    
        Database.database().reference(withPath: "booking").observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot.children.allObjects.count)
            if snapshot.children.allObjects.count == 0{
                self.commentsTextfield.text = "Available"
            }
            else{
                var bookedStatus = false
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
                timeFormatter.timeZone = NSTimeZone.local
                let LSTime = timeFormatter.date(from: date+" "+fromTime)
                let LETime = timeFormatter.date(from: date+" "+toTime)
                print(LSTime!,LETime!)
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    if let data : [String:Any] = snap.value as? [String:Any]{
                        print(data)
                        if let name : String = data["name"] as? String,let date : String = data["date"] as? String,let time1 : String = data["StartTime"] as? String, let time2 : String = data["EndTime"] as? String, let confinRoomNo : String = data["conferenceHall"] as? String{
                            print(name,date,time1,time2,confinRoomNo)
                            
                            let FSTime = timeFormatter.date(from: date+" "+time1)
                            let FETime = timeFormatter.date(from: date+" "+time2)
                            print(FSTime!,FETime!)
                            if  FSTime!.equalToDate(dateToCompare:LSTime!) ||
                                FSTime!.equalToDate(dateToCompare: LETime!) ||
                                FETime!.equalToDate(dateToCompare:LSTime!) ||
                                FETime!.equalToDate(dateToCompare: LETime!) ||
                                (FSTime!.isGreaterThanDate(dateToCompare: LSTime!) && FSTime!.isLessThanDate(dateToCompare: LETime!)) ||
                                (FETime!.isGreaterThanDate(dateToCompare: LSTime!) && FETime!.isLessThanDate(dateToCompare: LETime!)){
                                print("Room not avaiable")
                                bookedStatus = true
                                break
                            }
                        }
                    }
                }
                if !bookedStatus{
                    
                    
                    self.commentsTextfield.text = "Available"
                }else{
                    self.commentsTextfield.text = "Room Not Available"
                    
                }
            }
        })
    }
        
        
     
    
    
//    self.commentsTextfield.text = "Available"
//}
//else{
   // self.commentsTextfield.text = "Room Not Available"
//}
    /*    // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //    func retrievebookings() {
    //
    //        let messageDB = Database.database().reference().child("bookings")
    //
    //        messageDB.observe(.childAdded) { (snapshot) in
    //
    //            let snapshotValue = snapshot.value as! Dictionary<String,String>
    //            let text = snapshotValue["myData"]!
    //            let sender = snapshotValue["Sender"]!
    //
    //            let message = Message()
    //            message.messageBody = text
    //            message.sender = sender
    //
    //            self.messageArray.append(message)
    //
    //
    //
    //
    //
    //        }
    //
    //
    //
    //    }

    }

    
extension Date {
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
}





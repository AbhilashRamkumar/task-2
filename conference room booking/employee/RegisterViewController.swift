//
//  RegisterViewController.swift
//  conference room booking
//
//  Created by Admin on 30/03/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import FirebaseDatabase


struct post {
    let Name : String!
    let EmailId : String!
    
}

class RegisterViewController: UIViewController, UITextFieldDelegate {

    var abcd = 38

    @IBOutlet weak var NameDetails: UITextField!
    @IBOutlet weak var EmailDetails: UITextField!
    @IBOutlet weak var ContactDetails: UITextField!
    @IBOutlet weak var DepartmentDetails: UITextField!
    
    @IBOutlet weak var PaswordDetails: UITextField!

    @IBOutlet weak var registerPressed: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        self.NameDetails.delegate = self
        self.EmailDetails.delegate = self
        self.ContactDetails.delegate = self
        self.DepartmentDetails.delegate = self
        self.PaswordDetails.delegate = self
        
        
        DispatchQueue.main.async {
            self.NameDetails.layer.cornerRadius = 20
            self.EmailDetails.layer.cornerRadius = 20
            self.ContactDetails.layer.cornerRadius = 20
            self.DepartmentDetails.layer.cornerRadius = 20
            self.PaswordDetails.layer.cornerRadius = 20
            self.registerPressed.layer.cornerRadius = 20
        }
        
      
        
        NameDetails.addPadding(.both(20))
        EmailDetails.addPadding(.both(20))
         ContactDetails.addPadding(.both(20))
         DepartmentDetails.addPadding(.both(20))
         PaswordDetails.addPadding(.both(20))
    
        }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func registerPressed(_ sender: Any) {
       
        
       
        SVProgressHUD.show()
        
        
        Auth.auth().createUser(withEmail: EmailDetails.text!, password: PaswordDetails.text!) { (user, error) in
            SVProgressHUD.dismiss()
            if error != nil {
                print(error)
                
            }else {
                //Success
                print("Registration Successfull")
                
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "BookingLoginViewController", sender: self)
                
                
//                self.performSegue(withIdentifier: "BookingLoginViewController", sender: self)
                
               
            }
            
        }
        
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if (identifier == "BookingLoginViewController") {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
            DispatchQueue.main.async {
                    self.show(vc, sender: self)
            }
        }
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




extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        
        switch padding {
            
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}




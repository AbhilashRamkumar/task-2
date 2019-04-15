//
//  AdminLoginViewController.swift
//  conference room booking
//
//  Created by Admin on 01/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class AdminLoginViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var loginPressed: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.emailTextfield.delegate = self
        self.passwordTextfield.delegate = self
        
        
        self.emailTextfield.text = "xiphias.admin@gmail.com"

        self.passwordTextfield.text = "123456"

        
        self.emailTextfield.layer.cornerRadius = 20
        self.passwordTextfield.layer.cornerRadius = 20
        self.loginPressed.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        
        emailTextfield.addPadding(.both(20))
        passwordTextfield.addPadding(.both(20))
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                var myAlert = UIAlertController(title: "Allert", message: "All fields are requierd to e filled", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
                
                return
                
                
                
            }else {
                print("Login Successfull!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "BookingAdminViewController", sender: self)
                
            }
            
            
        }
        
        
    }
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if (identifier == "BookingAdminViewController") {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
            DispatchQueue.main.async {
                self.show(vc, sender: self)
            }
        }
        
        
    }
    
}

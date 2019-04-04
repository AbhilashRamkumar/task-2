//
//  BookingLoginViewController.swift
//  conference room booking
//
//  Created by Admin on 01/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class BookingLoginViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var emailTextfield: UITextField!
  
    

  
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginPressed: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.emailTextfield.delegate = self
        self.passwordTextfield.delegate = self
   
        
        
        
        self.emailTextfield.text = "xiphias.admin@gmail.com"
        self.passwordTextfield.text = "123456"


        DispatchQueue.main.async {

        self.emailTextfield.layer.cornerRadius = 20
        self.passwordTextfield.layer.cornerRadius = 20
            self.loginPressed.layer.cornerRadius = 20

        }
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

    @IBAction func loginPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                //show alert.
                print(error.localizedDescription)
                return
            }
            self.performSegue(withIdentifier: "BookingViewController", sender: self)
        }
        
        
    }
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if (identifier == "BookingViewController") {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
            DispatchQueue.main.async {
                self.show(vc, sender: self)
            }
        }
    }
}

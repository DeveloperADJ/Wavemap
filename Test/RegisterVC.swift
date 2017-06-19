//
//  RegisterVC.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 18/03/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordRegister1: UITextField!
    @IBOutlet weak var passwordRegister2: UITextField!
    @IBOutlet weak var errorTextLbl: UILabel!
    @IBOutlet weak var registerBtnLbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameField.delegate = self
        self.passwordRegister1.delegate = self
        self.passwordRegister2.delegate = self
        errorTextLbl.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // called when 'return' key pressed. return NO to ignore.
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    enum message: String {
        case success = "Registration successful"
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        errorTextLbl.isHidden = false
        if dictOfUsernamesAndPasswords.keys.contains(userNameField.text!){
            errorTextLbl.text = "Username is in use"
            
        } else if userNameField.text?.isEmpty == true || passwordRegister1.text?.isEmpty == true || passwordRegister2.text?.isEmpty == true{
            errorTextLbl.text = "Please fill out all fields"
            
        } else if (userNameField.text?.contains(" "))! || (passwordRegister1.text?.contains(" "))! || (passwordRegister2.text?.contains(" "))!{
            errorTextLbl.text = "Please do not use spaces in any of the fields"
            
        } else if passwordRegister1.text != passwordRegister2.text{
            errorTextLbl.text = "Passwords do not match, please try again."
            
        } else if dictOfUsernamesAndPasswords.keys.contains(userNameField.text!) == false {
            dictOfUsernamesAndPasswords.updateValue(passwordRegister1.text!, forKey: userNameField.text!)
            registerBtnLbl.isEnabled = false
            
            errorTextLbl.textColor = UIColor.green
            errorTextLbl.text = "Registration successful"
            
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when){
                self.dismiss(animated: true, completion: nil)}
        }
    }
}



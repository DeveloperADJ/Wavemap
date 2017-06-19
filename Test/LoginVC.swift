//
//  MainVC.swift
//  Test
//
//  Created by Arno de Jonge on 20/02/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit
import AVFoundation

class LoginVC: UIViewController, UITextFieldDelegate {
    

    
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var plateView: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        errorText.isHidden = true
        self.plateView.layer.cornerRadius = plateView.frame.height/2
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        checkForCorrectInputInFields(password: passwordTextField, username: usernameTextField, errorText: errorText)
        
        if errorText.text! == "Login Success!"{
        performSegue(withIdentifier: "loginSuccess", sender: nil)
        }
    }
    
    @IBAction func registerHereBtnPressed(_ sender: UIButton) {
        playSoundFX(SoundFX.tapeClick)
    }
    
}


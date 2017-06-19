//
//  [Login] Variables and Constants.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 18/03/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import Foundation
import UIKit

//Hide Text
func hideTextAfter(_ seconds: Double, showing error: UILabel){
    let when = DispatchTime.now() + seconds
    DispatchQueue.main.asyncAfter(deadline: when) {
        error.isHidden = true
    }
}

//Show Error
func showErrorWith(message: String, color: UIColor? = .red, errorText: UILabel){
    errorText.textColor = color
    errorText.isHidden = false
    errorText.text = message
    print(message)
    hideTextAfter(3.0, showing: errorText)
}

func checkForCorrectInputInFields(password: UITextField, username: UITextField, errorText: UILabel){

    if (password.text!.isEmpty) && (username.text!.isEmpty){
        showErrorWith(message: "Please enter a Username and Password", errorText: errorText)
    }
    else if (password.text?.isEmpty)!{
        showErrorWith(message: "Please enter a password", errorText: errorText)
    }
    else if (username.text?.isEmpty)!{
        showErrorWith(message: "Please enter a username", errorText: errorText)
    }
    else if dictOfUsernamesAndPasswords[username.text!] == password.text!{
        showErrorWith(message: "Login Success!", color: .green, errorText: errorText)
        playSoundFX(.forwardPiano)
        
    } else { showErrorWith(message: "Incorrect username / password combination", errorText: errorText)}
}




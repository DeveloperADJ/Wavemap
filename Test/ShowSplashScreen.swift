//
//  ShowSplashScreen.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 22/02/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit

class ShowSplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        perform(#selector(ShowSplashScreen.showNavController), with: nil, afterDelay: 3)
    }

    func showNavController(){
        
        performSegue(withIdentifier: "showSplashScreen", sender: self)
        
    }

}

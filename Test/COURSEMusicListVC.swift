//
//  COURSEMusicListVC.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 22/02/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit

class COURSEMusicListVC: UIViewController {
    @IBOutlet weak var userNameLbl: UILabel!
    
    private var _username: String!
        get{
            return _username
        } set {
            _username = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLbl.text = _username

        
        view.backgroundColor = UIColor.purple
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

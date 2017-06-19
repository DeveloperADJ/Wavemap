//
//  SelectMapVC.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 18/03/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit
import GoogleMaps
import AVFoundation

class SelectMapVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var tourBtnLbl: UIButton!
    @IBOutlet weak var musicBtnLbl: UIButton!
    @IBOutlet weak var goBtnLbl: UIButton!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //IBActions
    
    //Tour Button
    @IBAction func tourBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "TourSegue", sender: nil)
    }
    
    //Music Button
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "MusicSegue", sender: nil)
    }
    
    //Blue Button
    @IBAction func blueBtnPressed(_ sender: UIButton) {
        mapColor = arrayOfMapThemes[0]
    }
    
    //Black and White Button
    @IBAction func blackAndWhiteBtnPressed(_ sender: UIButton) {
        mapColor = arrayOfMapThemes[1]
    }
    
    //Pastel Button
    @IBAction func pastelBtnPressed(_ sender: UIButton) {
        mapColor = arrayOfMapThemes[3]
    }
    
    //Fanni Button
    @IBAction func fanniBtnPressed(_ sender: UIButton) {
        mapColor = arrayOfMapThemes[4]
    }
    
    //Logout button
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

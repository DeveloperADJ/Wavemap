//
//  TourVC.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 23/02/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit
import GoogleMaps
import AVFoundation

class TourVC: UIViewController, GMSMapViewDelegate//-------------------------------------------------------
{
    
    // Outlets
    @IBOutlet weak var songTitleLbl: UILabel!
    @IBOutlet var songTitleView: UIView!
    @IBOutlet weak var routeBtnLbl: UIBarButtonItem!
    @IBOutlet weak var stopBtn: UIBarButtonItem!
    
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    // Set the status bar style to complement night-mode.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //View did load-------------------------
    
    override func viewDidLoad() {
        
        stopBtn.isEnabled = false
        routeBtnLbl.isEnabled = false
        
    }
    
    // Animations-------------------------
    
    // Animate In
    
    func animateIn(){
        self.view.addSubview(songTitleView)
        songTitleView.center = self.view.center
        songTitleView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        songTitleView.alpha = 0
        UIView.animate(withDuration: 0.4){
            self.songTitleView.alpha = 1
            self.songTitleView.transform = CGAffineTransform.identity
        }
    }
    
    // Animate Out
    
    func animateOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.songTitleView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.songTitleView.alpha = 0
        }) { (completion:Bool) in
            self.songTitleView.removeFromSuperview()
        }
    }
    
    //WHEN THE VIEW LOADS-------------------------
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate 52.363938, 4.882579 at zoom level 17.
    
    override func loadView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 52.357533, longitude: 4.882103, zoom: 17.5, bearing: 0, viewingAngle: 150)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Set the map style by passing the URL of the local file.
        
        do { if let styleURL = Bundle.main.url(forResource: "pastel", withExtension: "json") {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
        } else {
            NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        ///Creates markers on the map-------------------------
        
        // 3/3 Add to array
        
        arrayOfSights.append(VanGoghMuseum)
        arrayOfSights.append(Rijksmuseum)
        arrayOfSights.append(StedelijkMuseum)
        
        
        /// Creates the markers on the map
        func createMarkerWith(venueName: Sights){
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: venueName.coordinates.latitude, longitude: venueName.coordinates.longitude)
            marker.title = "\(venueName.venueName)"
            marker.map = mapView
            marker.icon = #imageLiteral(resourceName: "play5")
        }
        
        
        for venue in arrayOfSights{
            
            createMarkerWith(venueName: venue)
            
        }
        
        self.view = mapView
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
    }
    
    //Buttons-------------------------
    
    //Close window Button
    
    
    @IBAction func closeBtnPressed(_ sender: UIBarButtonItem) {
        print("Closed Tour window")
        
        dismiss(animated: true, completion: nil)
        musicPlayer.stop()
        musicPlayer.currentTime = 0
        
        let path = Bundle.main.path(forResource: "BackwardEffect", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do{
            try musicPlayer = AVAudioPlayer(contentsOf: soundURL)
            
            musicPlayer.prepareToPlay()
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        musicPlayer.play()
        
        stopBtn.tintColor = UIColor.green
    }
    
    
    // Stop button
    @IBAction func stopBtnPressed(_ sender: UIBarButtonItem) {
        musicPlayer.stop()
        musicPlayer.currentTime = 0
        
        //Music player
        let path = Bundle.main.path(forResource: "tape-click", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do{
            try musicPlayer = AVAudioPlayer(contentsOf: soundURL)
            
            musicPlayer.prepareToPlay()
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        musicPlayer.play()
        
        stopBtn.tintColor = UIColor.green
    }
    
    
    
    /// Plays music and changes UI Button colors
    func playMusic(){
        
        if musicPlayer.isPlaying
        {
            musicPlayer.stop()
            musicPlayer.play()
            
            stopBtn.tintColor = UIColor.red
        }else
        {
            musicPlayer.play()
            
            stopBtn.tintColor = UIColor.red
        }
    }
    
    /// Opens the directions URL
    
    func getDirectionsToCoordinates(_ venue: Sights)
    {
        print("Getting directions to: \(venue.directionsURL())")
        
        let url = URL(string: venue.directionsURL())!
        
        if #available(iOS 10, *){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {UIApplication.shared.open(url)}
    }
    
    
    // Checks which directions to check for based on the club name
    @IBAction func routeBtnPressed(_ sender: UIBarButtonItem) {
        for sight in arrayOfSights{
            
            switch sight.venueName {
            case sight.venueName:
                getDirectionsToCoordinates(sight)
            default:
                print("coordinates loop did not work")
            }
            
        }
    }
    
    
    ///Checks if a marker is tapped-------------------------------------------------------------------------------------------------------------------
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        ///Plays music and changes interface
        func selectMarker(venue: Sights, marker: GMSMarker, fileType: String = "mp3"){
            
            //Buttons
            routeBtnLbl.isEnabled = true
            stopBtn.isEnabled = true
            routeBtnLbl.title = venue.venueName
            
            //Markers
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: venue.coordinates.latitude, longitude: venue.coordinates.longitude)
            marker.title = venue.venueName
            marker.snippet = "\(venue.eventName)"
            marker.map = mapView
            marker.icon = #imageLiteral(resourceName: "play5")
            
            //Song text
            self.songTitleView.removeFromSuperview()
            print("\(venue.venueName) marker is pressed.")
            songTitleLbl.text = "You are listening to: \(venue.songTitle)"
            animateIn()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {self.animateOut()})
            
            //Camera movement
            mapView.selectedMarker = marker
            mapView.animate(toLocation: marker.position)
            
            //Music player
            let path = Bundle.main.path(forResource: venue.songTitle, ofType: fileType)
            let soundURL = URL(fileURLWithPath: path!)
            do{
                try musicPlayer = AVAudioPlayer(contentsOf: soundURL)
                musicPlayer.prepareToPlay()
                
            } catch let err as NSError{
                print(err.debugDescription)
            }
            playMusic()
            
        }
        
        
        
        
        // Checks which marker is tapped and executes the appropriate action
        
        for venue in arrayOfSights{
            
            switch marker.title! {
            case venue.venueName:
                selectMarker(venue: venue, marker: venue.marker)
            default:
                print("This is printing for some reason")
            }
            
        }
        
        
        return true
    }
    
    //Infowindow taps-------------------------
    
    //Method detect tap on inFowindow
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        print("\(routeBtnLbl.title!)'s infowindow tapped")
        
        /// Opens the tickets link
        func buyTicketsFrom(venue: Sights)
        {let url = URL(string: "\(venue.ticketsURL)")!
            if #available(iOS 10.0, *)
            {UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {UIApplication.shared.openURL(url)}
        }
        // Check which infoWindow was tapped and show tickets website
        
        for venue in arrayOfSights{
            
            switch marker.title! {
            case venue.venueName: buyTicketsFrom(venue: venue)
            default:
                print("This shouldn't print")
            }
            
        }
        
    }
    
}












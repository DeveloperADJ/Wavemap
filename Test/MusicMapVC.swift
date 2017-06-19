//
//  MusicVC.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 23/02/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit
import GoogleMaps
import AVFoundation

class MusicMapVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate//-------------------------------------------------------
{
    
    // Outlets
    
    @IBOutlet weak var favouritesTableView: UITableView!
    @IBOutlet weak var routeBtnLbl: UIBarButtonItem!
    @IBOutlet weak var stopBtn: UIBarButtonItem!
    @IBOutlet weak var closeBtnLbl: UIBarButtonItem!
    @IBOutlet var songTitleView: UIView!
    @IBOutlet weak var songTitleLbl: UILabel!
    @IBOutlet var favouritesView: UIView!
    @IBOutlet weak var favouritesBtnLbl: UIBarButtonItem!
    @IBOutlet weak var heartsBannerView: UIVisualEffectView!
    @IBOutlet weak var heartsBannerView2: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    
    // Set the status bar style to complement night-mode.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //View did load-------------------------
    
    override func viewDidLoad() {
        stopBtn.isEnabled = false
        routeBtnLbl.isEnabled = false
        favouritesView.alpha = 0
    }
    
    //TableViews
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        return arrayOfFavourites.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = arrayOfFavourites[indexPath.row]
        cell.textLabel?.textColor = UIColor.gray
        cell.textLabel?.font = UIFont(name:"Avenir Next", size:17)
        return cell
    }
    
    // Animations-------------------------
    
    // Animate In
    
    func animateIn(subview: UIView , scale: CGFloat, duration: Double){
        self.view.addSubview(subview)
        subview.center = self.view.center
        subview.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        subview.alpha = 0
        UIView.animate(withDuration: duration){
            subview.alpha = 1
            subview.transform = CGAffineTransform.identity
        }
    }
    
    // Animate Out
    
    func animateOut(duration: Double, subview: UIView, scale: CGFloat){
        UIView.animate(withDuration: duration, animations: {
            subview.transform = CGAffineTransform.init(scaleX: scale, y: scale)
            subview.alpha = 0
        }) { (completion:Bool) in
            subview.removeFromSuperview()
        }
    }
    
    
    
    //Load View
    override func loadView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 52.363938,
                                              longitude: 4.882579,
                                              zoom: 18,
                                              bearing: 0,
                                              viewingAngle: 150)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        //Show My Location
        self.view = mapView
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        // Set the map style by passing the URL of the local file.
        do { if let styleURL = Bundle.main.url(forResource: "\(mapColor)", withExtension: "json") {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
        } else {
            NSLog("Unable to find \(mapColor).json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        /// Function to create markers on the map
        
        placeMarkers(view: mapView)
    }
    
    
    //Buttons-------------------------
    
    //Close window Button
    
    @IBAction func closeBtnPressed(_ sender: UIBarButtonItem) {
        print("Closed window")
        dismiss(animated: true, completion: nil)
        musicPlayer.stop()
        musicPlayer.currentTime = 0
        selectSoundFX(resource: SoundFX.backwardPiano, type: "wav")
        musicPlayer.play()
        stopBtn.tintColor = .green
    }

    // Stop button
    @IBAction func stopBtnPressed(_ sender: Any) {
        musicPlayer.stop()
        musicPlayer.currentTime = 0
        selectSoundFX(resource: SoundFX.tapeClick, type: "wav")
        musicPlayer.play()
        stopBtn.tintColor = .green
    }

    /// Opens the directions URL
    
    func getDirectionsToCoordinates(_ venue: Venues){
        print("Getting directions to: \(venue.directionsURL())")
        let url = URL(string: venue.directionsURL())!
        if #available(iOS 10, *){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {UIApplication.shared.open(url)}
    }
    
    
    
    
    ///Checks if a marker is tapped-------------------------------------------------------------------------------------------------------------------
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        print("did tap marker \(marker.title!)")
        ///Plays music and changes interface
        func selectMarker(venue: Venues, marker: GMSMarker, fileType: String = "mp3"){
            //Buttons
            routeBtnLbl.isEnabled = true
            stopBtn.isEnabled = true
            routeBtnLbl.title = "Route to: " + venue.venueName
            //Markers
            marker.position = CLLocationCoordinate2D(latitude: venue.coordinates.latitude, longitude: venue.coordinates.longitude)
            venue.marker.title = venue.venueName
            venue.marker.snippet = venue.eventDescription()
            venue.marker.map = mapView
            selectedVenue = venue
            if arrayOfFavourites.contains(venue.marker.title!){
                venue.marker.icon = favouriteIcon
            }else{
                venue.marker.icon = icon
            }
            
            //Song text
            print("\(venue.venueName) marker is pressed.")
            songTitleLbl.text = venue.songTitle
            animateIn(subview: songTitleView, scale: 1.3, duration: 0.4)
            let when = DispatchTime.now() + 6
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.animateOut(duration: 0.3, subview: self.songTitleView, scale: 1.3)
            }
            
            //Camera movement
            mapView.selectedMarker = marker
            mapView.animate(toLocation: marker.position)
            func updateCamera(){
                mapView.animate(toLocation: (dictOfVenues["Paradiso"]?.marker.position)!)
            }
            
            
            markerCurrentlySelected = marker
            
            //Music player
            
            selectMusic(resource: venue.songTitle, type: "mp3")
            
            stopBtn.tintColor = .red
            
            playMusic()
            
            
        }
        
        
        
        // Checks which marker is tapped and executes the appropriate action
        
        for venue in dictOfVenues{
            switch marker.title! {
            case venue.value.venueName:
                selectMarker(venue: venue.value, marker: venue.value.marker)
            default:
                break
            }
        }
        
        
        return true
    }
    
    
    // Checks which directions to check for based on the club name
    
    @IBAction func routeBtnPressed(_ sender: UIBarButtonItem) {
        if selectedVenue != nil{
            getDirectionsToCoordinates(selectedVenue!)
        }
    }
    
    //Infowindow taps-------------------------
    
    //Method detect tap on inFowindow
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        print("\(routeBtnLbl.title!)'s infowindow tapped")
        
        /// Opens the tickets link
        func buyTicketsFrom(venue: Venues)
        {let url = URL(string: "\(venue.ticketsURL)")!
            if #available(iOS 10.0, *)
            {UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {UIApplication.shared.openURL(url)}
        }
        // Check which infoWindow was tapped and show tickets website
        
        for venue in dictOfVenues{
            switch marker.title! {
            case venue.value.venueName: buyTicketsFrom(venue: venue.value)
            default:
                print("This shouldn't print (buy tickets from)")
            }
        }
    }
    
    //WaveMap Button
    
    
    
    @IBAction func wavemapBtnPressed(_ sender: UIButton) {
        print("WΔVEMAP button pressed")
        
        musicPlayer.stop()
        switchThemes()
        
        viewDidLoad()
        loadView()
        
        songTitleLbl.text = "Style set to: '\(mapColor)'"
        animateIn(subview: songTitleView, scale: 1.3, duration: 0.4)
        let when = DispatchTime.now() + 6
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.animateOut(duration: 0.3, subview: self.songTitleView, scale: 1.3)
        }
        
        print("Style set to: '\(mapColor)'")
    }
    
    
    //Favourites List Button
    @IBAction func favouritesBtnPressed(_ sender: UIBarButtonItem) {
        
        
        
        
        if favouritesView.alpha == 0{
            var array = arrayOfFavourites
            favouritesTableView.reloadData()
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return array.count
            }
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
                cell.textLabel?.text = array[indexPath.row] //+ "❤"
                return cell
            }
            animateIn(subview: self.favouritesView, scale: 0.0, duration: 0.4)
            favouritesView.alpha = 1
            print("Favourites list opened")
        } else if favouritesView.alpha == 1 {
            animateOut(duration: 0.3, subview: favouritesView, scale: 0.1)
            favouritesView.alpha = 0
            print("Favourites list closed")
        }
        
        
        
    }
    
    
    //When user taps a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellname = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        for venue in dictOfVenues{
            if cellname == venue.value.venueName{
                print("\(venue.value.venueName) favourite cell was tapped")
                selectMusic(resource: venue.value.songTitle, type: "mp3")
                playMusic()
                
                
            }
        }
    }
    
    @IBAction func favouritesCloseBtnPressed(_ sender: UIButton) {
        favouritesView.removeFromSuperview()
    }
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        if let selected = markerCurrentlySelected{
            if arrayOfFavourites.contains(selected.title!) == false{
                selected.icon = favouriteIcon
                arrayOfFavourites.append(selected.title!)
                print(arrayOfFavourites)
            }
            else if arrayOfFavourites.contains(selected.title!) == true{
                let indexNo = arrayOfFavourites.index(of: selected.title!)
                arrayOfFavourites.remove(at: indexNo!)
                selected.icon = icon
                print(arrayOfFavourites)
            }else{
                print("Favourite error")
            }
            favouritesTableView.reloadData()
        }
    }
}












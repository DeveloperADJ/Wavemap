//
//  MapVC.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 21/02/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation


//-----------------------------------------------------------------------------------------------------------------------------------------------
class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //AV Audio Player
    var btnSound: AVAudioPlayer!
    
    
    
    //Outlets
    @IBOutlet weak var playBtnLbl: UIButton!
    @IBOutlet var map: MKMapView!
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //variables & constants
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        //?
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        

        
        
    }
    
    
    //Buttons
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var pauseBtnLbl: UIButton!
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    //ViewDidLoad
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //my location
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //Sounds
        
        //variables
        
        let path = Bundle.main.path(forResource:/*filename*/ "Daft Punk - One More Time - from YouTube", ofType:/*filetype*/ "mp3")
        let soundURL = URL(fileURLWithPath: path!)
        
        //do, try, catch
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        
   
        
        //maps
        
        self.map.delegate = self
        
        //Set Annotation
        
        //Annotation variables SAE
        
        let centerLocationSAE = CLLocationCoordinate2DMake(
            52.3853206, 4.9285932 )
        
        let mapSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let mapRegion = MKCoordinateRegionMake(centerLocationSAE, mapSpan)
        
        let annotation = MKPointAnnotation()
        
        //?
        
        annotation.coordinate = centerLocationSAE
        annotation.title = "SAE Amsterdam"
        annotation.subtitle = "Zoom out to view Clubs"
        
        map.addAnnotation(annotation)
        
        self.map.setRegion(mapRegion, animated: true)
        
        
     // Annotation with image
        
//        let info1 = CustomPointAnnotation()
//        info1.coordinate = CLLocationCoordinate2DMake(52.3853206, 4.9285932)
//        info1.title = "Hello"
//        info1.subtitle = "Subtitle"
//        info1.imageName = "SAE_international_logo"
//        
//        let info2 = CustomPointAnnotation()
//        info2.coordinate = CLLocationCoordinate2DMake(26.862280, 75.815098)
//        info2.title = "Hello2"
//        info2.subtitle = "Subtitle"
//        info2.imageName = "SAE_international_logo"
//        
//        map.addAnnotation(info1)
//        map.addAnnotation(info2)
        
        let annotationIdentifier = "SomeCustomIdentifier"
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
            
            // Resize image
            let pinImage = UIImage(named: "pin maps.png")
            let size = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(size)
            pinImage!.drawInRect(CGRectMake(0, 0, size.width, size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            annotationView?.image = resizedImage
            
            let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
            annotationView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            annotationView?.annotation = annotation
        }

        
    }
    
    
    
    
    
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        ///Works
        print("delegate called")
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomPointAnnotation
        anView?.image = UIImage(named:cpa.imageName)
        
        return anView
    }
    
    

    //IBActions
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func numberPressed(_ sender: UIButton) {
        playSound()
        playBtnLbl.isHidden = true
        pauseBtnLbl.isHidden = false
    }
    @IBAction func pauseBtnPressed(_ sender: Any) {
        
        pauseBtnLbl.isHidden = true
        playBtnLbl.isHidden = false
        
    }
    
    
    
    //Playsound Function
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }else{
            btnSound.play()
        }
    }

}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

        
        
        
        
        
        
        
        
        
        

        





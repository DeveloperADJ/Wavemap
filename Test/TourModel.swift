//
//  Variables and Constants.swift
//  WaveWalk
//
//  Created by Arno de Jonge on 27/02/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import Foundation
import GoogleMaps
import AVFoundation

//Markers
//1/3-------------------------------------------------------------------------------------------------------------

let vangoghmuseum = GMSMarker()
let rijksmuseum = GMSMarker()
let stedelijkmuseum = GMSMarker()

/// The Main Structure for all of the clubs
struct Sights{
    
    let marker: GMSMarker
    let venueName: String
    let eventName: String
    let songTitle: String
    let ticketsURL: String
    let coordinates: (latitude: Double, longitude: Double)
    
    func directionsURL()-> String {
        
        
        return "comgooglemaps://?saddr=&daddr=\(coordinates.latitude),\(coordinates.longitude)&directionsmode=driving"
    }
    
    func createMarkerWith(venueName: String, latitude: Double, longitude: Double){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "\(venueName)"
        marker.icon = #imageLiteral(resourceName: "play")
    }
    
}

//Venue Array
var arrayOfSights: [Sights] = []

// The Individual Venue properties
// 2/3---------------------------------------------------------------------------------------------------------


//Van Gogh Museum
let VanGoghMuseum = Sights(
    
    marker: vangoghmuseum,
    venueName: "Van Gogh Museum",
    eventName: "The Van Gogh Museum is an art museum dedicated to the works of Vincent van Gogh and his contemporaries.",
    songTitle: "Rick Steves Europe - The Van Gogh Museum",
    ticketsURL: "https://www.vangoghmuseum.nl/en",
    coordinates: (52.358416, 4.881069))

//Rijksmuseum
let Rijksmuseum = Sights(
    
    marker: rijksmuseum,
    venueName: "Rijksmuseum",
    eventName: "The Rijksmuseum is a Dutch national museum dedicated to arts and history in Amsterdam.",
    songTitle: "Rick Steves Europe - Rijksmuseum",
    ticketsURL: "https://www.rijksmuseum.nl/en",
    coordinates: (52.359999, 4.885221))

//Stedelijk Museum
let StedelijkMuseum = Sights(
    
    marker: stedelijkmuseum,
    venueName: "Stedelijk Museum",
    eventName: "The Stedelijk Museum Amsterdam, colloquially known as the Stedelijk, is a museum for modern art, contemporary art, and design",
    songTitle: "Travel+Leisure - Stedelijk Museum",
    ticketsURL: "http://www.stedelijk.nl/en",
    coordinates: (52.358011, 4.879753))







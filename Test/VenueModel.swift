//
//  VenueModel.swift
//  Wavemap
//
//  Created by Arno de Jonge on 25/05/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import Foundation
import GoogleMaps

var selectedVenue: Venues?
var markerCurrentlySelected: GMSMarker?

//Favourites Array
var arrayOfFavourites: [String] = []

func placeMarkers(view: GMSMapView){
    for venue in dictOfVenues{
        createMarkerWith(for: venue.value, in: view)
    }
}

func createMarkerWith(for venue: Venues, in view: GMSMapView){
    let marker = venue.marker
    marker.position = CLLocationCoordinate2D(latitude: venue.coordinates.latitude, longitude: venue.coordinates.longitude)
    marker.title = "\(venue.venueName)"
    marker.map = view
    marker.icon = icon
}

/// The Main Structure for all of the clubs
struct Venues{
    
    var marker = GMSMarker()
    let venueName: String
    let eventName: String
    let from: String
    let until: String
    let songTitle: String
    let ticketsURL: String
    let coordinates: (latitude: Double, longitude: Double)
    var icon: UIImage
    
    func eventDescription() -> String {
        return "\n\(eventName)! Tonight from \(from) - \(until)\n\nTap this window to buy tickets!"
    }
    
    func directionsURL()-> String {
        return "comgooglemaps://?saddr=&daddr=\(coordinates.latitude),\(coordinates.longitude)&directionsmode=driving"
    }
    
}

let dictOfVenues: [String: Venues] = [
    
    "Paradiso": Venues.init(
        marker: GMSMarker(),
        venueName: "Paradiso",
        eventName: "Noodlanding",
        from: "20:00",
        until: "04:00",
        songTitle: "Arctic Monkeys - R U Mine",
        ticketsURL: "http://www.paradiso.nl",
        coordinates: (52.362311, 4.884003),
        icon: #imageLiteral(resourceName: "play")),
    
    "Melkweg": Venues.init(
        marker: GMSMarker(),
        venueName: "Melkweg",
        eventName: "ENCORE",
        from: "20:00",
        until: "04:00",
        songTitle: "Jay-Z & Kanye West - Ni**as In Paris",
        ticketsURL: "http://www.melkweg.nl",
        coordinates: (52.364846, 4.881345),
        icon: #imageLiteral(resourceName: "play")),
    
    "Chicago Social Club": Venues.init(
        marker: GMSMarker(),
        venueName: "Chicago Social Club",
        eventName: "Super Social",
        from: "20:00",
        until: "04:00",
        songTitle: "Disclosure - White Noise ft. AlunaGeorge",
        ticketsURL: "http://chicagosocialclub.nl/",
        coordinates: (52.364649, 4.882640),
        icon: #imageLiteral(resourceName: "play")),
    
    "Sugarfactory": Venues.init(
        marker: GMSMarker(),
        venueName: "Sugarfactory",
        eventName: "Salsa Night",
        from: "20:00",
        until: "04:00",
        songTitle: "Buena Vista Social Club - El Cuarto de Tula",
        ticketsURL: "https://www.sugarfactory.nl/",
        coordinates: (52.364806, 4.881816),
        icon: #imageLiteral(resourceName: "play")),
    
    "Het Concertgebouw": Venues.init(
        marker: GMSMarker(),
        venueName: "Het Concertgebouw",
        eventName: "Carmen",
        from: "20:00",
        until: "04:00",
        songTitle: "Maria Callas - L'amour est un oiseau rebelle",
        ticketsURL: "https://www.concertgebouw.nl/",
        coordinates: (52.356321, 4.879188),
        icon: #imageLiteral(resourceName: "play")),
    
    "Winston Kingdom": Venues.init(
        marker: GMSMarker(),
        venueName: "Winston Kingdom",
        eventName: "Cheeky Monday",
        from: "20:00",
        until: "04:00",
        songTitle: "Super Sharp Shooter - The Ganja Kru",
        ticketsURL: "http://www.winston.nl/",
        coordinates: (52.373847, 4.896331),
        icon: #imageLiteral(resourceName: "play")),
    
    "Overtoom 301": Venues.init(
        marker: GMSMarker(),
        venueName: "Overtoom 301",
        eventName: "Reggae & Dub",
        from: "20:00",
        until: "04:00",
        songTitle: "Subatomic Sound System - Black Ark Vampires",
        ticketsURL: "http://www.ot301.nl/",
        coordinates: (52.360091, 4.865674),
        icon: #imageLiteral(resourceName: "play")),
    
    "Pacificparc": Venues.init(
        marker: GMSMarker(),
        venueName: "Pacificparc",
        eventName: "Surf Rock",
        from: "20:00",
        until: "04:00",
        songTitle: "Daikaiju - The Trouble With Those Mothra Girls",
        ticketsURL: "http://www.pacificparc.nl/",
        coordinates: (52.385986, 4.871443),
        icon: #imageLiteral(resourceName: "play")),
    
    "De School": Venues.init(
        marker: GMSMarker(),
        venueName: "De School",
        eventName: "Techno",
        from: "20:00",
        until: "04:00",
        songTitle: "Jeff Mills - The Bells",
        ticketsURL: "http://www.deschoolamsterdam.nl/en/",
        coordinates: (52.370056, 4.843406),
        icon: #imageLiteral(resourceName: "play")),
    
    "Dutch National Opera & Ballet": Venues.init(
        marker: GMSMarker(),
        venueName: "Dutch National Opera & Ballet",
        eventName: "The Nutcracker",
        from: "20:00",
        until: "04:00",
        songTitle: "Tchaikovsky - The Nutcracker Suite, Op 71a",
        ticketsURL: "http://www.operaballet.nl/",
        coordinates: (52.367250, 4.901028),
        icon: #imageLiteral(resourceName: "play")),
    
    "OCCII": Venues.init(
        marker: GMSMarker(),
        venueName: "OCCII",
        eventName: "Konono no1 Live",
        from: "20:00",
        until: "04:00",
        songTitle: "Konono No.1 - Yaya Mikolo",
        ticketsURL: "http://occii.org/",
        coordinates: (52.354343, 4.855409),
        icon: #imageLiteral(resourceName: "play")),
    
    "Bimhuis": Venues.init(
        marker: GMSMarker(),
        venueName: "Bimhuis",
        eventName: "Jazz",
        from: "20:00",
        until: "04:00",
        songTitle: "Charlie Parker - I've Got Rhythm",
        ticketsURL: "http://bimhuis.nl/home",
        coordinates: (52.377977, 4.912792),
        icon: #imageLiteral(resourceName: "play")),
    
    "Maloe Melo": Venues.init(
        marker: GMSMarker(),
        venueName: "Maloe Melo",
        eventName: "Heavy Metal",
        from: "20:00",
        until: "04:00",
        songTitle: "Iron Maiden - Run To The Hills",
        ticketsURL: "https://www.maloemelo.com/",
        coordinates: (52.370035, 4.877776),
        icon: #imageLiteral(resourceName: "play")),
    
    "Bourbon Street": Venues.init(
        marker: GMSMarker(),
        venueName: "Bourbon Street",
        eventName: "Blues",
        from: "20:00",
        until: "04:00",
        songTitle: "Howlin' Wolf - Smokestack Lightnin'",
        ticketsURL: "http://www.bourbonstreet.nl/",
        coordinates: (52.363874, 4.885325),
        icon: #imageLiteral(resourceName: "play")),
    
    "Club Up": Venues.init(
        marker: GMSMarker(),
        venueName: "Club Up",
        eventName: "PALM PARADISE",
        from: "20:00",
        until: "04:00",
        songTitle: "Dj Luck & Mc Neat - Im Sorry",
        ticketsURL: "http://www.clubup.nl/",
        coordinates: (52.363812, 4.883677),
        icon: #imageLiteral(resourceName: "play")),
    
    "Club AIR": Venues.init(
        marker: GMSMarker(),
        venueName: "AIR",
        eventName: "House",
        from: "20:00",
        until: "04:00",
        songTitle: "Adam Lambert - Ghost Town (Deep House Remix)",
        ticketsURL: "http://www.air.nl/",
        coordinates: (52.366147, 4.899081),
        icon: #imageLiteral(resourceName: "play")),
    
    "Escape": Venues.init(
        marker: GMSMarker(),
        venueName: "Escape",
        eventName: "Dirty House",
        from: "20:00",
        until: "04:00",
        songTitle: "Dj Chuckie - Who is ready to jump (Original Mix)",
        ticketsURL: "http://escape.nl/",
        coordinates: (52.366426, 4.896355),
        icon: #imageLiteral(resourceName: "play")),
    
    "Jimmy Woo": Venues.init(
        marker: GMSMarker(),
        venueName: "Jimmy Woo",
        eventName: "UH-OH",
        from: "20:00",
        until: "04:00",
        songTitle: "LeLe - BreakFast",
        ticketsURL: "https://www.jimmywoo.com/",
        coordinates: (52.364755, 4.882199),
        icon: #imageLiteral(resourceName: "play")),
    
    "Westerunie": Venues.init(
        marker: GMSMarker(),
        venueName: "Westerunie",
        eventName: "90's Rave",
        from: "20:00",
        until: "04:00",
        songTitle: "DJ Dano - Mayday",
        ticketsURL: "http://www.westerunie.nl/",
        coordinates: (52.387134, 4.870013),
        icon: #imageLiteral(resourceName: "play")),
    
    "Studio 80": Venues.init(
        marker: GMSMarker(),
        venueName: "Studio 80",
        eventName: "ErrorKr3w",
        from: "20:00",
        until: "04:00",
        songTitle: "Rugon Crowen - Iwazu",
        ticketsURL: "http://www.studio-80.nl/",
        coordinates: (52.366576, 4.896984),
        icon: #imageLiteral(resourceName: "play")),
    
    "Bitterzoet": Venues.init(
        marker: GMSMarker(),
        venueName: "Bitterzoet",
        eventName: "Hip-Hop",
        from: "20:00",
        until: "04:00",
        songTitle: "Flying Lotus - Massage Situation",
        ticketsURL: "https://www.bitterzoet.com/",
        coordinates: (52.377393, 4.894134),
        icon: #imageLiteral(resourceName: "play")),
    
    "Canvas": Venues.init(
        marker: GMSMarker(),
        venueName: "Canvas",
        eventName: "Soulection",
        from: "20:00",
        until: "04:00",
        songTitle: "Cypria - The Sweetest Thing",
        ticketsURL: "https://www.volkshotel.nl/en/canvas#club-canvas",
        coordinates: (52.353788, 4.911929),
        icon: #imageLiteral(resourceName: "play")),
    
    "Disco Dolly": Venues.init(
        marker: GMSMarker(),
        venueName: "Disco Dolly",
        eventName: "Break Ya Neck",
        from: "20:00",
        until: "04:00",
        songTitle: "Mos Def - Mathematics",
        ticketsURL: "http://www.discodolly.nl/",
        coordinates: (52.368074, 4.890187),
        icon: #imageLiteral(resourceName: "play")),
    
    "Supperclub": Venues.init(
        marker: GMSMarker(),
        venueName: "Supperclub",
        eventName: "R&B",
        from: "20:00",
        until: "04:00",
        songTitle: "The Weeknd - Starboy ft. Daft Punk",
        ticketsURL: "http://supperclub.amsterdam/en",
        coordinates: (52.367547, 4.888832),
        icon: #imageLiteral(resourceName: "play")),
    
    "Muziekgebouw aan 't IJ": Venues.init(
        marker: GMSMarker(),
        venueName: "Muziekgebouw aan 't IJ",
        eventName: "Tosca Opera",
        from: "20:00",
        until: "04:00",
        songTitle: "Puccini - Tosca",
        ticketsURL: "http://www.muziekgebouw.nl/",
        coordinates: (52.378251, 4.913439),
        icon: #imageLiteral(resourceName: "play")),
    
    "CC Music Cafe": Venues.init(
        marker: GMSMarker(),
        venueName: "CC Music Cafe",
        eventName: "Open Mic",
        from: "20:00",
        until: "04:00",
        songTitle: "Slow Jeff & the Tears - Pillionaire",
        ticketsURL: "http://cccafe.amsterdam/",
        coordinates: (52.351611, 4.891907),
        icon: #imageLiteral(resourceName: "play")),
    
    "De Marktkantine": Venues.init(
        marker: GMSMarker(),
        venueName: "De Marktkantine",
        eventName: "Adriatique Live",
        from: "20:00",
        until: "04:00",
        songTitle: "Adriatique - Lophobia (Original Mix)",
        ticketsURL: "http://www.marktkantine.nl/",
        coordinates: (52.376209, 4.866993),
        icon: #imageLiteral(resourceName: "play")),
    
    "Panama": Venues.init(
        marker: GMSMarker(),
        venueName: "Panama",
        eventName: "We All Love 80's 90's 00's",
        from: "20:00",
        until: "04:00",
        songTitle: "Stardust - Music Sounds Better With You",
        ticketsURL: "http://www.panama.nl/events/we-all-love-80s-90s-00s-1",
        coordinates: (52.375015, 4.930508),
        icon: #imageLiteral(resourceName: "play")),
    
    "Closure": Venues.init(
        marker: GMSMarker(),
        venueName: "Closure",
        eventName: "Techno",
        from: "20:00",
        until: "04:00",
        songTitle: "Leftfield - Universal Everything",
        ticketsURL: "https://www.facebook.com/pg/closureamsterdam/about/?ref=page_internal",
        coordinates: (52.372694, 4.878927),
        icon: #imageLiteral(resourceName: "play")),
    
    "Bloemenbar": Venues.init(
        marker: GMSMarker(),
        venueName: "Bloemenbar",
        eventName: "70's Disco",
        from: "20:00",
        until: "04:00",
        songTitle: "Kool & The Gang - Hollywood Swinging",
        ticketsURL: "http://www.bloemenbar.nl/",
        coordinates: (52.367250, 4.901028),
        icon: #imageLiteral(resourceName: "play"))
]

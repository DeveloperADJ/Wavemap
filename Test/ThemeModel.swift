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

//Map Colour Themes

var mapColor = arrayOfMapThemes[0]
var arrayOfMapThemes: [String] = [
    "blue",
    "blackAndWhite",
    "pastel",
    "greyAndWhite"
]

//These Arrays must have equal amounts

//Marker Icons
var icon = arrayOfIcons[0]
var arrayOfIcons: [UIImage] = [
    #imageLiteral(resourceName: "play"),
    #imageLiteral(resourceName: "play-white"),
    #imageLiteral(resourceName: "play-icon-pastel"),
    #imageLiteral(resourceName: "play5")
]

// Function that switches theme colors
var tapCounter = 0
func switchThemes(){
    
    if tapCounter < (arrayOfMapThemes.count-1){
        tapCounter += 1
    } else {
        tapCounter = 0
    }
    
    mapColor = arrayOfMapThemes[tapCounter]
    icon = arrayOfIcons[tapCounter]
}









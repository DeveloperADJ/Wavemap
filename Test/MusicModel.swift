//
//  MusicModel.swift
//  Wavemap
//
//  Created by Arno de Jonge on 25/05/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import Foundation
import AVFoundation

var musicPlayer: AVAudioPlayer!
var FXPlayer: AVAudioPlayer!



//Music

func selectMusic(resource: String, type: String){
    
    let path = Bundle.main.path(forResource: resource, ofType: type)
    let soundURL = URL(fileURLWithPath: path!)
    do{
        try musicPlayer = AVAudioPlayer(contentsOf: soundURL)
        
        musicPlayer.prepareToPlay()
        
    } catch let err as NSError{
        print(err.debugDescription)
    }
}

func playMusic(){
    if musicPlayer.isPlaying{
        musicPlayer.stop()
        musicPlayer.play()
    }else{
        musicPlayer.play()
    }
}

//Sound FX

enum SoundFX: String {
    case backwardPiano
    case forwardPiano
    case tapeClick
}

func selectSoundFX(resource: SoundFX, type: String){
    
    let path = Bundle.main.path(forResource: resource.rawValue, ofType: type)
    let soundURL = URL(fileURLWithPath: path!)
    do{
        try musicPlayer = AVAudioPlayer(contentsOf: soundURL)
        
        musicPlayer.prepareToPlay()
        
    } catch let err as NSError{
        print(err.debugDescription)
    }
}

func playSoundFX(_ file: SoundFX){
    let path = Bundle.main.path(forResource: file.rawValue, ofType: "wav")
    let soundURL = URL(fileURLWithPath: path!)
    do{
        try musicPlayer = AVAudioPlayer(contentsOf: soundURL)
        musicPlayer.prepareToPlay()
        
    } catch let err as NSError{
        print(err.debugDescription)
    }
    musicPlayer.play()
}




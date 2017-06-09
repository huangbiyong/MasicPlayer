//
//  MusicTool.swift
//  音乐播放器
//
//  Created by huangbiyong on 2017/4/21.
//  Copyright © 2017年 test. All rights reserved.
//

import UIKit
import AVFoundation

class MusicTool: NSObject {
    //static let shareIntance = MusicTool()
    //var index1: NSInteger = 0
    
    var songs:[Music]? = []
    fileprivate var currentIndex:Int = 0 {
        
        didSet {
            
            guard let songs =  songs else {
                return
            }
            
            if currentIndex >= 0 && currentIndex < songs.count {
                self.currentMusic = songs[currentIndex]
            }
        }
    }
    
    var currentMusic:Music?
    
    var player:AVAudioPlayer?
    
    var songValue:TimeInterval? {
        didSet {
            guard let songValue = songValue else {
                return
            }
            self.player?.currentTime = songValue
        }
    }
    
    var volumeValue:Float? {
        didSet {
            guard let volumeValue = volumeValue else {
                return
            }
            self.player?.volume = volumeValue
        }
    }

    init(songs:[String]) {
        super.init()
        
        for song in songs {
            let music = Music.init(songName: song)
            self.songs?.append(music)
            
        }
        
        guard let songs = self.songs else {
            return
        }
        
        currentIndex = 0
        self.currentMusic = songs[currentIndex]
        prepareForInterfaceBuilder()
    }
    
}

//MARK: - 操作方法
extension MusicTool {
    private func prepareToPlayWithMusic() {
        do {
            player = try AVAudioPlayer.init(contentsOf: URL(fileURLWithPath: self.songs![currentIndex].mp3Path!))
            player?.prepareToPlay()
        }catch {
            
        }
    }
    
    func play() {
        prepareToPlayWithMusic()
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func next() {
        guard let songs = songs else {
            return
        }
        
        currentIndex += 1
        if currentIndex >= songs.count {
            currentIndex = 0
        }
        play()
    }
    
    func per() {
        guard let songs = songs else {
            return
        }
        
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = songs.count-1
        }
        play()
    }
}
















































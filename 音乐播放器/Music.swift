//
//  Music.swift
//  音乐播放器
//
//  Created by huangbiyong on 2017/4/21.
//  Copyright © 2017年 test. All rights reserved.
//

import UIKit

class Music: NSObject {
    var songTitle:String?
    var lrcArray:[String]? = []
    var timeArray:[TimeInterval]? = []
    
    var mp3Path:String?
    
    
    init(songName:String) {
        super.init()
        
        mp3Path = Bundle.main.path(forResource: songName, ofType: "mp3")
        let lrcPath = Bundle.main.path(forResource: songName, ofType: "lrc")
        
        do {
            let contentStr = try String.init(contentsOfFile: lrcPath!, encoding: String.Encoding.utf8)
            let contents = contentStr.components(separatedBy: "\n")
            
            for i in 0..<contents.count {
                
                let str = contents[i]
                if i == 0 {
                    //获取音乐标题
                    songTitle = getSongTitle(str)
                }else {
                    //获取歌词 和 时间
                    let songs = str.components(separatedBy: "]")
                    let times = songs.first!.components(separatedBy: "[")
                    
                    if songs.last! != "" && times.last!.contains(":") == true {
                        lrcArray?.append(songs.last!)
                        
                        let time = getSongTime(times.last!)
                        timeArray?.append(time)
                    }
                }
            }
        }catch {
        
        }
    }
}

//MARK: - 获取内容
extension Music {
    
    fileprivate func getSongTitle(_ str:String) -> String {
        let contents = str.components(separatedBy: "]")
        let names = contents.first?.components(separatedBy: "ti:")
        return names!.last!
    }
    
    fileprivate func getSongTime(_ str:String) -> TimeInterval {
        
        let minute = TimeInterval(str.components(separatedBy: ":").first!)!*TimeInterval(60)
        let second = TimeInterval(str.components(separatedBy: ":").last!)!
        let time = minute+second
        
        return time
    }
}













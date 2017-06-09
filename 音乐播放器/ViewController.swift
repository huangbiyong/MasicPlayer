//
//  ViewController.swift
//  音乐播放器
//
//  Created by huangbiyong on 2017/4/21.
//  Copyright © 2017年 test. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var songProgressSlider: UISlider!
    
    var musicTool:MusicTool!
    var timer:Timer?
    
    var currentIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tbView.dataSource = self
        tbView.delegate = self
        
        musicTool = MusicTool.init(songs: ["情非得已","林俊杰-背对背拥抱","梁静茹-偶阵雨"])
        tbView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "MusicCell")
        
        tbView.backgroundView = UIImageView.init(image: UIImage(named: "backgroundImage"))
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timeChange), userInfo: nil, repeats: true)
    }

    
    @IBAction func startClick(_ sender: UIButton) {
    
        if let isPlaying = musicTool.player?.isPlaying {
            
            if isPlaying == false {
                musicTool.play()
                songProgressSlider.maximumValue = Float((musicTool.player?.duration)!)
                sender.setTitle("暂停", for: .normal)
            }else {
                musicTool.pause()
                sender.setTitle("播放", for: .normal)
            }
        }else {
            musicTool.play()
            songProgressSlider.maximumValue = Float((musicTool.player?.duration)!)
            sender.setTitle("暂停", for: .normal)
        }
    }
    
    @IBAction func perClick(_ sender: Any) {
        musicTool.per()
        self.currentIndex = 0
        tbView.reloadData()
    }
    
    @IBAction func nextClick(_ sender: Any) {
        musicTool.next()
        self.currentIndex = 0
        tbView.reloadData()
    }
    
    @IBAction func songValueChange(_ sender: UISlider) {
        musicTool.songValue = TimeInterval(sender.value)
    }
    
    @IBAction func volumeValueChange(_ sender: UISlider) {
        musicTool.volumeValue = sender.value
    }
  
}

//MARK: - UITableView代理方法
extension ViewController: UITableViewDelegate,UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = musicTool.currentMusic?.lrcArray?.count  else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell")
        cell?.textLabel?.text = musicTool.currentMusic?.lrcArray?[indexPath.row]
        
        cell?.backgroundColor = UIColor.clear
        
        if  self.currentIndex == indexPath.row {
            cell?.textLabel?.textColor = UIColor.red
        }else {
            cell?.textLabel?.textColor = UIColor.black
        }
        
        return cell!
    }
}

extension ViewController {
    func timeChange() {
        
        if let currentTime = musicTool.player?.currentTime , let timeArray = musicTool.currentMusic?.timeArray {
            songProgressSlider.value = Float(currentTime)
            
            for i in 0..<timeArray.count {
                let time = timeArray[i]
                
                if currentTime > time {
                    self.currentIndex = i
                }else {
                    break
                }
            }
            tbView.scrollToRow(at: IndexPath.init(row: self.currentIndex, section: 0), at: .middle, animated: true)
        }
        
        tbView.reloadData()
    }
}




































//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes: [ String: Int16 ] = [ "Soft": 10, "Medium": 420, "Hard": 720 ]
    
    var secondsTotal: Int16 = 0
    var secondsPassed: Int16 = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelection(_ sender: UIButton) {
        resetTimer()
        titleLabel.text = sender.currentTitle!
        secondsTotal = eggTimes[sender.currentTitle!]!
        runTimer()
    }
    
    func resetTimer() {
        timer.invalidate()
        timerProgress.progress = 0.0
        timerLabel.text = ""
        secondsPassed = 0
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        let progress = Float(secondsPassed)/Float(secondsTotal)
        timerProgress.setProgress(progress, animated: true)
        if secondsPassed < secondsTotal {
            timerLabel.text = timeString(time: secondsTotal-secondsPassed)
            secondsPassed += 1
        }
        else {
            timerLabel.text = "Done!"
            timer.invalidate()
            playSound(resource: "alarm_sound", file: "mp3")
        }
    }
    
    func timeString(time: Int16) -> String {
        let minutes = time / 60 % 60
        let seconds = time % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func playSound(resource: String!, file: String!) {
        let url = Bundle.main.url(forResource: resource, withExtension: file)
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}

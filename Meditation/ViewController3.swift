//
//  ViewController3.swift
//  Meditation
//
//  Created by Лада on 05.07.2022.
//

import UIKit
import AVFoundation

class ViewController3: UIViewController {
    
    
    @IBOutlet weak var sleepButtonImage: UIImageView!
    @IBOutlet weak var buttonOn: UIButton!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var startButtonImage: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sleepLabel: UILabel!
  
    var alarmDate = 0.0
    var count = 0
    var timer: Timer?
    var player = AVAudioPlayer()
    var playerRelax = AVAudioPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sleepButtonImage.isHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "grass3.jpeg")!)
        

        view.addSubview(datePicker)
        datePicker.setValue(UIColor.white, forKey: "textColor")
        
        datePicker.addTarget(self, action: #selector(datePickerAction(sender:)), for: .valueChanged)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        } else {
            print("error")
        }
        
        view.addSubview(buttonOn)
        buttonOn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }
    func createTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self]_ in
            if self.count == 0 {
                self.stopSoundRelax()
                self.playSound()
                self.remainingTimeLabel.isHidden = true
                self.stopTimer()

            } else {
                
                self.count -= 1
                let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds: self.count)
                
                self.remainingTimeLabel.text = "осталось \(h):\(m):\(s)"
                
            }
        })
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    func stopTimer() {
        timer?.invalidate()
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("error")
        }
        playerRelax.stop()
        player.play()
    }
    func stopSound() {
        player.stop()
        self.remainingTimeLabel.isHidden = true
        self.remainingTimeLabel.text = " "
    }
    func playSoundRelax() {
        guard let url = Bundle.main.url(forResource: "relax", withExtension: "mp3") else {return}
        do {
            playerRelax = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("error")
        }
        playerRelax.play()
    }
    func stopSoundRelax() {
        playerRelax.stop()
    }
    
    @objc func datePickerAction(sender: UIDatePicker) {
        alarmDate = sender.date.timeIntervalSince1970
    }
    @objc func buttonAction(sender: UIButton){
        if sender.title(for: .normal) == "Приступить ко сну"{
            sender.setTitle("Проснуться", for: .normal)
            self.remainingTimeLabel.isHidden = false
            self.sleepButtonImage.isHidden = false
            self.startButtonImage.isHidden = true
            count = Int(self.alarmDate) - Int(Date().timeIntervalSince1970)
            createTimer()
            playSoundRelax()
        } else {
            sender.setTitle("Приступить ко сну", for: .normal)
            
            self.startButtonImage.isHidden = false
            self.sleepButtonImage.isHidden = true
            playerRelax.stop()
            stopSound()
            
        }
    }
}

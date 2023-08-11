//
//  ViewController4.swift
//  Meditation
//
//  Created by Лада on 05.07.2022.
//

import UIKit



class ViewController4: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
        
        
        
        var timer = Timer()
            var time = 30 {
                didSet {
                    timeLabel.text = "\(time)"
                }
            }
            
            
            
        @IBAction func restart(_ sender: Any) {
            timer.invalidate()
            time = 30
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        }
        
            override func viewDidAppear(_ animated: Bool) {
                super.viewDidAppear(animated)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
            }
            
            @objc func tick() {
                time -= 1
                
                if time == 0 {
                    timer.invalidate()
                    statusLabel.text = "Медитация завершена"
                }
            }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "qKl1kW72dWk.jpeg")!)

           
        }

        
        

              
}

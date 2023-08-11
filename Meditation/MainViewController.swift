//
//  MainViewController.swift
//  Meditation
//
//  Created by Лада on 07.07.2022.
//

import UIKit

class MainViewController: UIViewController{

    @IBOutlet weak var ButtomFocus: UIButton!
    @IBOutlet weak var ButtomSleep: UIButton!
    @IBOutlet weak var ButtomNap: UIButton!
    @IBOutlet weak var ButtomMusic: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "qKl1kW72dWk.jpeg")!)
    }
    
    
    
    
    
     @IBAction func FocusButtom(_ sender: Any) {
     guard let VC2 = storyboard?.instantiateViewController(withIdentifier: "ViewController2") else {return}
     present(VC2, animated: true)
     }


     @IBAction func SleepButtom(_ sender: Any) {
     guard let VC3 = storyboard?.instantiateViewController(withIdentifier: "ViewController3") else {return}
     present(VC3, animated: true)
     }


     @IBAction func NapButtom(_ sender: Any) {
     guard let VC4 = storyboard?.instantiateViewController(withIdentifier: "ViewController4") else {return}
     present(VC4, animated: true)
     }



     @IBAction func MusicButtom(_ sender: Any) {
     guard let VC1 = storyboard?.instantiateViewController(withIdentifier: "ViewController1") else {return}
     present(VC1, animated: true)
     }


}

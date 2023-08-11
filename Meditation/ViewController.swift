//
//  ViewController.swift
//  Meditation
//
//  Created by Лада on 05.07.2022.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var LableTxtHello: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var NextButtom: UIButton!
    

    @IBAction func NextButtom(_ sender: Any) {
        guard let username = nameTextField.text else {return}
        if username.count > 2 {
            guard let unlockVC = storyboard?.instantiateViewController(withIdentifier: "HelloViewController") as? HelloViewController else {return}
            unlockVC.userName1 = username
            present(unlockVC, animated: true)
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hloRlPwmzvc.jpeg")!)

    }

}

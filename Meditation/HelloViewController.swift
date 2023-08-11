//
//  HelloViewController.swift
//  Meditation
//
//  Created by Лада on 06.07.2022.
//

import UIKit

class HelloViewController: UIViewController {

    @IBOutlet weak var HelloName: UILabel!

    var userName1: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "lW8Eb05EwgE.jpeg")!)
        
        if let userName1 = userName1 {
            HelloName.text = "Привет, \(userName1)!"
        }
    }

}

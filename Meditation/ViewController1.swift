//
//  ViewController1.swift
//  Meditation
//
//  Created by Лада on 05.07.2022.
//

import UIKit

class ViewController1: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albomName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {return}
        
        vc.songs = songs
        vc.position = position
        
        present (vc, animated: true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        configureSongs()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "qKl1kW72dWk.jpeg")!)
    

    }
    
    func configureSongs() {
        songs.append(Song(name: "Голос леса",
                          albomName: " ",
                          artistName: " ",
                          imageName: "APNRUr9ESNs.jpeg",
                          trackName: "song1"))
        
        songs.append(Song(name: "Ночью в лесу",
                          albomName: " ",
                          artistName: " ",
                          imageName: "gnM6TL99PVc.jpeg",
                          trackName: "song2"))
        
        songs.append(Song(name: "Пение птиц",
                          albomName: " ",
                          artistName: " ",
                          imageName: "aCm3S9Uj60E.jpeg",
                          trackName: "song3"))
        
        songs.append(Song(name: "Гроза",
                          albomName: " ",
                          artistName: " ",
                          imageName: "LnFIe8DKd7Q.jpeg",
                          trackName: "song4"))
        
  
    }

}

struct Song {
    let name: String
    let albomName: String
    let artistName: String
    let imageName: String
    let trackName: String

}

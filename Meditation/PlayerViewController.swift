//
//  PlayerViewController.swift
//  Meditation
//
//  Created by Лада on 11.07.2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    private let albomImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private let songNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let playPauseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configure()
        }
        
    }
    
    func configure() {
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                print("urlString is nil")
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                print("player is nil")
                return
            }
            
            player.volume = 0.75
 
            player.play()

        }
        catch {
            print("error occurred")
        }
        
        
        
        
        albomImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        
        albomImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albomImageView)
       
        
        
        
        songNameLabel.frame = CGRect(x: 10,
                                      y: albomImageView.frame.size.height + 10,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albomImageView.frame.size.height + 10 + 70,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                      y: albomImageView.frame.size.height + 10 + 140,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        
        songNameLabel.text = song.name
        albumNameLabel.text = song.albomName
        artistNameLabel.text = song.artistName
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        let nextButton = UIButton()
        let backButton = UIButton()
        
        
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 40
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0 ,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 70 ,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        backButton.frame = CGRect(x: 70,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        nextButton.tintColor = .black
        backButton.tintColor = .black
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        let slider = UISlider(frame: CGRect(x: 39, y: 720, width: 336, height: 29))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSliderSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
    }
    
    @objc func didTapBackButton(){
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    
    @objc func didTapNextButton(){
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    
    @objc func didTapPlayButton(){
        if player?.isPlaying == true {
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.albomImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width-60,
                                                   height: self.holder.frame.size.width-60)
            })
        } else {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.albomImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: self.holder.frame.size.width-20,
                                                   height: self.holder.frame.size.width-20)
                
            })
        }
    }
    
    @objc func didSliderSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
    }
    
 
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
            
        }
    }

}

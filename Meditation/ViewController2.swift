//
//  ViewController2.swift
//  Meditation
//
//  Created by Лада on 10.07.2022.
//

import UIKit
import MediaPlayer

class ViewController2: UIViewController {

    @IBOutlet weak var elipseImage: UIImageView!
      @IBOutlet weak var krugImage: UIImageView!
      @IBOutlet weak var timerLabel: UILabel!
      @IBOutlet weak var startStopButton: UIButton!
      @IBOutlet weak var resetButton: UIButton!
      
      var timer:Timer = Timer()
      var count:Int = 0
      var timerCounting:Bool = false
      var player:AVPlayer!
      var context = CIContext(options: nil)
      
      override func viewDidLoad() {
          super.viewDidLoad()
          //ссылка на музыку
          player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Son_u_morya_www_oum_ru", ofType: "mp3")!))
          //анимация лоадинга
          let animation = CABasicAnimation(keyPath: "transform.rotation")
          animation.toValue = Double.pi * 2
          animation.repeatCount = MAXFLOAT
          animation.duration = 27
          krugImage.layer.add(animation, forKey: nil)
          //добавление фонового изображения
          let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
          backgroundImage.image = UIImage(named: "more.jpg")
          self.view.insertSubview(backgroundImage, at: 0)
          
      }
      
      
      //кнопка стоп(сброса времени)
      @IBAction func resetTapped(_ sender: Any)
      {
          //при нажатии на кнопку стоп скрываю анимацию
          self.elipseImage.isHidden = true
          //сохраняю время, на котором нажали кнопку
          let endtime = self.timerLabel.text!
          //вызываю алерт с уточнением действия
          let alertq = UIAlertController(title: "закончить фокусирование?", message: "вы уверенны, что хотите закончить фокусирование?", preferredStyle: .alert)
          //поменяла дефолтный синий цвет текста на черный
          alertq.view.tintColor = UIColor.black
          //если нажимаю на "нет", то возвращаю к моменту до нажатия стоп
          alertq.addAction(UIAlertAction(title: "нет", style: .cancel, handler: { (_) in
                      //do nothing
                  }))
                  //если нажимаю на "да", то сбрасываю таймер, останавливаю музыку
                  alertq.addAction(UIAlertAction(title: "да", style: .default, handler: { (_) in
                      self.count = 0
                      self.timer.invalidate()
                      self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
                      self.player.pause()
                      
                      //меняю текст кнопки с "продолжить" на "начать"
                      self.startStopButton.setTitle("начать", for: .normal)
                      //анимированно возвращаю кнопку в начальное положение
                      var framestartStop = self.startStopButton.frame
                      framestartStop.origin = CGPoint(x: 155, y: 631)
                      framestartStop.size = CGSize(width: 105.0, height: 36.0)
                      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                      self.startStopButton.frame = framestartStop
                      }) { (true) in
                      }
                      //так же анимированно возвращаю кнопку "стоп" за первую
                      var framereset = self.resetButton.frame
                      framereset.origin = CGPoint(x: 155, y: 631)
                      framereset.size = CGSize(width: 105.0, height: 36.0)
                      UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut, animations: {
                      self.resetButton.frame = framereset
                      }) { (true) in
                      }

                      //показываю, сколько фокусировался человек
                      let alertend = UIAlertController(title: "фокусирование завершилось", message: "вы фокусировались \(endtime)", preferredStyle: .alert)
                      alertend.view.tintColor = UIColor.black
                      alertend.addAction(UIAlertAction(title: "хорошо", style: .cancel, handler: {(_) in
                          //do nothing
                      }))
                      self.present(alertend, animated: true, completion: nil)
                  }))
                  
                  self.present(alertq, animated: true, completion: nil)
          
      }
      
      //кнопка старт(пауза, продолжить)
      @IBAction func startStopTapped(_ sender: Any)
      {
          //если музыка играла-приостанавливаю, если не играла-запускаю
          if player.timeControlStatus == .playing{
              player.pause()
          } else{
              player.play()
          }
          //если время шло(те при нажатии на "пауза")- останавливаю счетчик таймер
          if(timerCounting)
          {
              timerCounting = false
              timer.invalidate()
              //меняю кнопку "пауза" на "продолжить" и анимированно смещаю влево
              startStopButton.setTitle("продолжить", for: .normal)
              var framestartStop = self.startStopButton.frame
              framestartStop.size = CGSize(width: 149.0, height: 36.0)
              framestartStop.origin = CGPoint(x: 70, y: 631)
              UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
              self.startStopButton.frame = framestartStop
              }) { (true) in
              }
              //анимированно смещаю кнопку "выйти" вправо
              var framereset = self.resetButton.frame
              framereset.origin = CGPoint(x: 240, y: 631)
              framereset.size = CGSize(width: 105.0, height: 36.0)
              UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut, animations: {
              self.resetButton.frame = framereset
              }) { (true) in
              }
              //скрываю анимацию увеличения элипса
              elipseImage.isHidden = true
          }
                  else
                  {
                      //если время не шло(те при нажатии на "продолжить" или "старт")-запускаю таймер и счетчик
                      timerCounting = true
                      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
                      
                      //меняю кнопку "продолжить"(или "старт") на "паузу" и анимированно возвращаю в начальное положение
                      startStopButton.setTitle("пауза", for: .normal)
                      var framestartStop = self.startStopButton.frame
                      framestartStop.origin = CGPoint(x: 155, y: 631)
                      framestartStop.size = CGSize(width: 105.0, height: 36.0)
                      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                      self.startStopButton.frame = framestartStop
                      }) { (true) in
                      }
                      //возвращаю кнопку "выйти" в начальное положение
                      var framereset = self.resetButton.frame
                      framereset.origin = CGPoint(x: 155, y: 631)
                      framereset.size = CGSize(width: 105.0, height: 36.0)
                      UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut, animations: {
                      self.resetButton.frame = framereset
                      }) { (true) in
                      }
                      //запускаю анимацию увеличения элипса
                      animateImage()
                      elipseImage.isHidden = false
                  }
      }
      
      //функция счетчик времени
      @objc func timerCounter() -> Void
      {
              count = count + 1
              let time = secondsToHoursMinutesSeconds(seconds: count)
              let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
              timerLabel.text = timeString
      }
      
      //функция разделения на часы, минуты и секунды
      func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
          {
              return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
          }
       
      //функция приведения времени к строковому виду
      func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
      {
          var timeString = ""
          timeString += String(format: "%02d", hours)
          timeString += " : "
          timeString += String(format: "%02d", minutes)
          timeString += " : "
          timeString += String(format: "%02d", seconds)
          return timeString
      }
      
      //функция анимирования(увеличения) элипса
      func animateImage() {
          _ = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0.2, animations:{
              UIView.setAnimationRepeatCount(MAXFLOAT)
              self.elipseImage.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
              self.elipseImage.alpha = 0.0
          })
      }
      

}

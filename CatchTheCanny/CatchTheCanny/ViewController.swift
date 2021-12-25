//
//  ViewController.swift
//  CatchTheCanny
//
//  Created by Doğanay Şahin on 31.07.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    
    @IBOutlet weak var kenny2: UIImageView!
    
    @IBOutlet weak var kenny3: UIImageView!
    
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    
    
    @IBOutlet weak var kenny7: UIImageView!
    
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    
    
    @IBOutlet weak var kenny9: UIImageView!
    var score = 0;
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        kenny1.isUserInteractionEnabled = true;
        kenny2.isUserInteractionEnabled = true;
        kenny3.isUserInteractionEnabled = true;
        kenny4.isUserInteractionEnabled = true;
        kenny5.isUserInteractionEnabled = true;
        kenny6.isUserInteractionEnabled = true;
        kenny7.isUserInteractionEnabled = true;
        kenny8.isUserInteractionEnabled = true;
        kenny9.isUserInteractionEnabled = true;
        
        let recognizer1 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny1.addGestureRecognizer(recognizer1)
        
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny2.addGestureRecognizer(recognizer2)
        
        
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny3.addGestureRecognizer(recognizer3)
        
        let recognizer4 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny4.addGestureRecognizer(recognizer4)
        
        let recognizer5 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny5.addGestureRecognizer(recognizer5)
        
        let recognizer6 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny6.addGestureRecognizer(recognizer6)
        
        
        let recognizer7 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny7.addGestureRecognizer(recognizer7)
        
        let recognizer8 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny8.addGestureRecognizer(recognizer8)
        
        
        let recognizer9 = UITapGestureRecognizer(target: self, action:#selector(addScore))
        kenny9.addGestureRecognizer(recognizer9)
        
        
        counter = 30;
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeCounter), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(moveToKenny), userInfo: nil, repeats: true)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        
        moveToKenny()
    }

    @objc func addScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    @objc func timeCounter(){
        
        timeLabel.text = "\(counter)"
        counter -= 1
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time is Over"
            
            
            if self.score > self.highScore{
                self.highScore = self.score
                self.highScoreLabel.text = "High Score : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time is Over", message: "Play Again?", preferredStyle: UIAlertController.Style.alert)
            
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            let okButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCounter), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.moveToKenny), userInfo: nil, repeats: true)
            }
            
            
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func moveToKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
}




import UIKit

class ViewController: UIViewController {
   
//    Variable
    var score = 0
    var timer = Timer()
    var counter = 0
    var uzayArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
//    Views
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var imageview1: UIImageView!
    @IBOutlet weak var imageview2: UIImageView!
    @IBOutlet weak var imageview3: UIImageView!
    @IBOutlet weak var imageview4: UIImageView!
    @IBOutlet weak var imageview5: UIImageView!
    @IBOutlet weak var imageview6: UIImageView!
    @IBOutlet weak var imageview7: UIImageView!
    @IBOutlet weak var imageview8: UIImageView!
    @IBOutlet weak var imageview9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highest Score : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highest Score : \(highScore)"
        }
        
        
        imageview1.isUserInteractionEnabled = true
        imageview2.isUserInteractionEnabled = true
        imageview3.isUserInteractionEnabled = true
        imageview4.isUserInteractionEnabled = true
        imageview5.isUserInteractionEnabled = true
        imageview6.isUserInteractionEnabled = true
        imageview7.isUserInteractionEnabled = true
        imageview8.isUserInteractionEnabled = true
        imageview9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector((increaseScore)))
        
        imageview1.addGestureRecognizer(recognizer1)
        imageview2.addGestureRecognizer(recognizer2)
        imageview3.addGestureRecognizer(recognizer3)
        imageview4.addGestureRecognizer(recognizer4)
        imageview5.addGestureRecognizer(recognizer5)
        imageview6.addGestureRecognizer(recognizer6)
        imageview7.addGestureRecognizer(recognizer7)
        imageview8.addGestureRecognizer(recognizer8)
        imageview9.addGestureRecognizer(recognizer9)

        
        uzayArray = [imageview1, imageview2, imageview3, imageview4, imageview5, imageview6, imageview7, imageview8, imageview9]
        
        counter  = 10
        timerLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimer), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: #selector(hideUzay), userInfo: nil, repeats: true)
        
        hideUzay()
    }
    
    @objc func hideUzay (){
        for imageView in uzayArray {
            imageView.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(uzayArray.count - 1)))
        uzayArray[random].isHidden = false
        
    }
    
    
    
    @objc func gameTimer() {
        timerLabel.text = "\(counter)"
        counter -= 1
        
        if counter < 0 {
            
            timer.invalidate()
            hideTimer.invalidate()
            

            for imageView in uzayArray {
                imageView.isHidden = true
                
                if self.score > self.highScore {
                    self.highScore = self.score
                    highScoreLabel.text = "Highest Score : \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highScore")
                }
            }
    let alert = UIAlertController(title: "Time is over", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
    let okButton  = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {(UIAlertAction) in
        
        self.score = 0
        self.scoreLabel.text = "Score : \(self.score)"
        self.counter = 10
        self.timerLabel.text = String(self.counter)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.gameTimer), userInfo: nil, repeats: true)
        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: #selector(self.hideUzay), userInfo: nil, repeats: true)
        
        
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score : \(score)"
        

        
        
        
    }
    


}


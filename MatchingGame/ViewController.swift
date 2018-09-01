//
//  ViewController.swift
//  MatchingGame
//
//  Created by Luke Bradford on 5/28/18.
//  Copyright © 2018 Luke Bradford. All rights reserved.
//
//TODO: Make sure only one button can be tapped at a time.

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var minutes = 0
    var seconds = 0
    var tens = 0
    
    var pressedCt = 0
    var moves = 0
    var matches = 0
    var v1 = UIColor.lightGray
    var v2 = UIColor.lightGray
    
    //Today
    //var colors = [UIColor]()
    var colors = Array(repeating: UIColor.gray, count: 17)
    var enablerToggles = Array(repeating: 1, count: 17)
    var onToggles = Array(repeating: 0, count: 17)
    
    var buttons: [UIButton] = [UIButton]()
    //Today
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //timeLabel.text = String(counter)
        self.buttons = [self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.button16]
        
        //ME
        defaultBackground()
        newGame()
        
        //ME
        timeLabel.text = "00:00.0"
        
        //ME
        pauseButton.isEnabled = false
        
      
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
        //timeLabel.text = String(format: "%.1f", counter)
        minutes = Int(floor(counter/60))
        seconds = Int(floor(counter)) % 60
        tens = Int(counter * 10)%10
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strTens = String(format: "%01d", tens)
        
        timeLabel.text = "\(strMinutes):\(strSeconds).\(strTens)"
        
    }
    
    func newGame() {
        var choices: [UIColor] = [UIColor.blue, UIColor.green, UIColor.orange, UIColor.red, UIColor.purple, UIColor.yellow, UIColor.brown, UIColor.black, UIColor.blue, UIColor.green, UIColor.orange, UIColor.red, UIColor.purple, UIColor.yellow, UIColor.brown, UIColor.black]
     
        for i in 1...16 {
            let random = choices[Int(arc4random_uniform(UInt32(choices.count)))]
            let index = choices.index(of: random)
            choices.remove(at: index!)
            colors[i] = random
        }
        pressedCt = 0
        
        //enable all buttons
        
    }
    
    func defaultBackground() {
        button1.backgroundColor = UIColor.lightGray
        button2.backgroundColor = UIColor.lightGray
        button3.backgroundColor = UIColor.lightGray
        button4.backgroundColor = UIColor.lightGray
        button5.backgroundColor = UIColor.lightGray
        button6.backgroundColor = UIColor.lightGray
        button7.backgroundColor = UIColor.lightGray
        button8.backgroundColor = UIColor.lightGray
        button9.backgroundColor = UIColor.lightGray
        button10.backgroundColor = UIColor.lightGray
        button11.backgroundColor = UIColor.lightGray
        button12.backgroundColor = UIColor.lightGray
        button13.backgroundColor = UIColor.lightGray
        button14.backgroundColor = UIColor.lightGray
        button15.backgroundColor = UIColor.lightGray
        button16.backgroundColor = UIColor.lightGray
    }
    
   
    

    //MARK: Actions
    @IBAction func startTimer(_ sender: UIButton) {
        //assgin random colors to game
        //enable all gameplay buttons
        if(isPlaying) {
            return
        }
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    @IBAction func pauseTimer(_ sender: UIButton) {
        //All gameplay buttons need to be disabled
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
    }
    
    //new game function first assign new random colors then enable all gameplay buttons
    
    @IBAction func resetTimer(_ sender: UIButton) {
        //assign original random colors
        //enable all gameplay buttons
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        //timeLabel.text = String(counter)
        timeLabel.text = "00:00.0"
    }
    
    @IBAction func button1(_ sender: UIButton) {
        //Respond only if play has been pressed
        if ((pressedCt == 0) && (enablerToggles[1] == 1)){
            button1.backgroundColor = colors[1]
            pressedCt = pressedCt + 1
            enablerToggles[1] = 0
            onToggles[1] = 1
            v1 = colors[1]
        }
        
        if ((pressedCt == 1) && enablerToggles[1] == 1){
            moves = moves + 1
            button1.backgroundColor = colors[1]
            v2 = colors[1]
            onToggles[1] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
       

    }
    
    
    @IBAction func button2(_ sender: UIButton) {
        if ((pressedCt == 0) && (enablerToggles[2] == 1)){
            button2.backgroundColor = colors[2]
            pressedCt = pressedCt + 1
            enablerToggles[2] = 0
            onToggles[2] = 1
            v1 = colors[2]
        }
        
        if ((pressedCt == 1) && enablerToggles[2] == 1){
            moves = moves + 1
            button2.backgroundColor = colors[2]
            v2 = colors[2]
            onToggles[2] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    @IBAction func button3(_ sender: UIButton) {
        if ((pressedCt == 0) && (enablerToggles[3] == 1)){
            button3.backgroundColor = colors[3]
            pressedCt = pressedCt + 1
            enablerToggles[3] = 0
            onToggles[3] = 1
            v1 = colors[3]
        }
        
        if ((pressedCt == 1) && enablerToggles[3] == 1){
            moves = moves + 1
            button3.backgroundColor = colors[3]
            v2 = colors[3]
            onToggles[3] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }

    }
    
    @IBAction func button4(_ sender: UIButton) {
        if ((pressedCt == 0) && (enablerToggles[4] == 1)){
            button4.backgroundColor = colors[4]
            pressedCt = pressedCt + 1
            enablerToggles[4] = 0
            onToggles[4] = 1
            v1 = colors[4]
        }
        
        if ((pressedCt == 1) && enablerToggles[4] == 1){
            moves = moves + 1
            button4.backgroundColor = colors[4]
            v2 = colors[4]
            onToggles[4] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button5(_ sender: UIButton) {
        if ((pressedCt == 0) && (enablerToggles[5] == 1)){
            button5.backgroundColor = colors[5]
            pressedCt = pressedCt + 1
            enablerToggles[5] = 0
            onToggles[5] = 1
            v1 = colors[5]
        }
        
        if ((pressedCt == 1) && enablerToggles[5] == 1){
            moves = moves + 1
            button5.backgroundColor = colors[5]
            v2 = colors[5]
            onToggles[5] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button6(_ sender: UIButton) {
        if ((pressedCt == 0) && (enablerToggles[6] == 1)){
            button6.backgroundColor = colors[6]
            pressedCt = pressedCt + 1
            enablerToggles[6] = 0
            onToggles[6] = 1
            v1 = colors[6]
        }
        
        if ((pressedCt == 1) && enablerToggles[6] == 1){
            moves = moves + 1
            button6.backgroundColor = colors[6]
            v2 = colors[6]
            onToggles[6] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button7(_ sender: UIButton) {
        //EXAMPLE
        //button7.backgroundColor = colors[7]
        if ((pressedCt == 0) && (enablerToggles[7] == 1)){
            button7.backgroundColor = colors[7]
            pressedCt = pressedCt + 1
            enablerToggles[7] = 0
            onToggles[7] = 1
            v1 = colors[7]
        }
        
        if ((pressedCt == 1) && enablerToggles[7] == 1){
            moves = moves + 1
            button7.backgroundColor = colors[7]
            v2 = colors[7]
            onToggles[7] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button8(_ sender: UIButton) {
        //EXAMPLE
        //button8.backgroundColor = colors[8]
        if ((pressedCt == 0) && (enablerToggles[8] == 1)){
            button8.backgroundColor = colors[8]
            pressedCt = pressedCt + 1
            enablerToggles[8] = 0
            onToggles[8] = 1
            v1 = colors[8]
        }
        
        if ((pressedCt == 1) && enablerToggles[8] == 1){
            moves = moves + 1
            button8.backgroundColor = colors[8]
            v2 = colors[8]
            onToggles[8] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button9(_ sender: UIButton) {
        //button9.backgroundColor = colors[9]
        if ((pressedCt == 0) && (enablerToggles[9] == 1)){
            button9.backgroundColor = colors[9]
            pressedCt = pressedCt + 1
            enablerToggles[9] = 0
            onToggles[9] = 1
            v1 = colors[9]
        }
        
        if ((pressedCt == 1) && enablerToggles[9] == 1){
            moves = moves + 1
            button9.backgroundColor = colors[9]
            v2 = colors[9]
            onToggles[9] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    @IBAction func button10(_ sender: UIButton) {
        //button10.backgroundColor = colors[10]
        if ((pressedCt == 0) && (enablerToggles[10] == 1)){
            button10.backgroundColor = colors[10]
            pressedCt = pressedCt + 1
            enablerToggles[10] = 0
            onToggles[10] = 1
            v1 = colors[10]
        }
        
        if ((pressedCt == 1) && enablerToggles[10] == 1){
            moves = moves + 1
            button10.backgroundColor = colors[10]
            v2 = colors[10]
            onToggles[10] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button11(_ sender: UIButton) {
        //button11.backgroundColor = colors[11]
        if ((pressedCt == 0) && (enablerToggles[11] == 1)){
            button11.backgroundColor = colors[11]
            pressedCt = pressedCt + 1
            enablerToggles[11] = 0
            onToggles[11] = 1
            v1 = colors[11]
        }
        
        if ((pressedCt == 1) && enablerToggles[11] == 1){
            moves = moves + 1
            button11.backgroundColor = colors[11]
            v2 = colors[11]
            onToggles[11] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button12(_ sender: UIButton) {
        //button12.backgroundColor = colors[12]
        if ((pressedCt == 0) && (enablerToggles[12] == 1)){
            button12.backgroundColor = colors[12]
            pressedCt = pressedCt + 1
            enablerToggles[12] = 0
            onToggles[12] = 1
            v1 = colors[12]
        }
        
        if ((pressedCt == 1) && enablerToggles[12] == 1){
            moves = moves + 1
            button12.backgroundColor = colors[12]
            v2 = colors[12]
            onToggles[12] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button13(_ sender: UIButton) {
        //button13.backgroundColor = colors[13]
        if ((pressedCt == 0) && (enablerToggles[13] == 1)){
            button13.backgroundColor = colors[13]
            pressedCt = pressedCt + 1
            enablerToggles[13] = 0
            onToggles[13] = 1
            v1 = colors[13]
        }
        
        if ((pressedCt == 1) && enablerToggles[13] == 1){
            moves = moves + 1
            button13.backgroundColor = colors[13]
            v2 = colors[13]
            onToggles[13] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button14(_ sender: UIButton) {
        //button14.backgroundColor = colors[14]
        if ((pressedCt == 0) && (enablerToggles[14] == 1)){
            button14.backgroundColor = colors[14]
            pressedCt = pressedCt + 1
            enablerToggles[14] = 0
            onToggles[14] = 1
            v1 = colors[14]
        }
        
        if ((pressedCt == 1) && enablerToggles[14] == 1){
            moves = moves + 1
            button14.backgroundColor = colors[14]
            v2 = colors[14]
            onToggles[14] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button15(_ sender: UIButton) {
        //button15.backgroundColor = colors[15]
        if ((pressedCt == 0) && (enablerToggles[15] == 1)){
            button15.backgroundColor = colors[15]
            pressedCt = pressedCt + 1
            enablerToggles[15] = 0
            onToggles[15] = 1
            v1 = colors[15]
        }
        
        if ((pressedCt == 1) && enablerToggles[15] == 1){
            moves = moves + 1
            button15.backgroundColor = colors[15]
            v2 = colors[15]
            onToggles[15] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func button16(_ sender: UIButton) {
        //button16.backgroundColor = colors[16]
        if ((pressedCt == 0) && (enablerToggles[16] == 1)){
            button16.backgroundColor = colors[16]
            pressedCt = pressedCt + 1
            enablerToggles[16] = 0
            onToggles[16] = 1
            v1 = colors[16]
        }
        
        if ((pressedCt == 1) && enablerToggles[16] == 1){
            moves = moves + 1
            button16.backgroundColor = colors[16]
            v2 = colors[16]
            onToggles[16] = 1
            for i in 1...16{
                enablerToggles[i] = 0
            }
            if(v1 == v2){
                matches = matches + 1
                for i in 1...16{
                    if (onToggles[i] == 0){
                        enablerToggles[i] = 1
                    }
                    else{
                        onToggles[i] = 2
                    }
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for i in 1...16{
                        self.enablerToggles[i] = 1
                        if (self.onToggles[i] == 1){
                            self.onToggles[i] = 0
                            self.buttons[i-1].backgroundColor = UIColor.lightGray
                        }
                    }
                }
            }
            pressedCt = 0
        }
    }
    
    @IBAction func NewGame(_ sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = "00:00.0"
        defaultBackground()
        newGame()
        //HANDLE ENABLERS and ONTOGGLES ETC
        
    }
    
}


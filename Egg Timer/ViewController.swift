//
//  ViewController.swift
//  Egg Timer
//
//  Created by Igor Skripnik on 19.11.2018.
//  Copyright © 2018 garik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var softBoiledBtn: UIButton!
    @IBOutlet weak var inAPouchBtn: UIButton!
    @IBOutlet weak var hardBoiledBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    let softBoiledConst = 10
    let inAPouchConst = 360
    let hardBoiledConst = 450
    
    var selectedType = Array(repeating: false, count: 3)
    var timer = Timer()
    var isStarted = false
    var counter: Int?
    
    @IBAction func softBoiledBtnPressed(_ sender: Any) {
        if !isStarted {
            selectedType[2] = false
            selectedType[1] = false
            selectedType[0] = true
            setHighlightingForButtons()
            refreshTimer()
        }
    }
    
    @IBAction func inAPouchBtnPressed(_ sender: Any) {
        if !isStarted {
            selectedType[2] = false
            selectedType[1] = true
            selectedType[0] = false
            setHighlightingForButtons()
            refreshTimer()
        }
    }
    
    @IBAction func hardBoiledBtnPressed(_ sender: Any) {
        if !isStarted {
            selectedType[2] = true
            selectedType[1] = false
            selectedType[0] = false
            setHighlightingForButtons()
            refreshTimer()
        }
    }
    
    @IBAction func startBtnPressed(_ sender: Any) {
        if !isStarted {
            counter = getCurrentTimer()
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: true)
            startBtn.setImage(UIImage.init(named: "stop"), for: UIControl.State())
            isStarted = true
            disabledButtons()
        } else {
            isStarted = false
            timer.invalidate()
            refreshTimer()
            enabledButtons()
            setHighlightingForButtons()
            startBtn.setImage(UIImage.init(named: "play"), for: UIControl.State())
        }
    }
    
    @objc func timerAction() {
        counter! -= 1
        if counter! < 0 {
            timerLabel.text = "READY"
        } else {
            timerLabel.text = NSString(format: "%0.2d:%0.2d", counter!/60, counter!%60) as String
        }
    }
    
    func refreshTimer() {
        counter = getCurrentTimer()
        timerLabel.text = NSString(format: "%0.2d:%0.2d", counter!/60, counter!%60) as String
    }
    
    
    func disabledButtons() {
        softBoiledBtn.isEnabled = false
        inAPouchBtn.isEnabled = false
        hardBoiledBtn.isEnabled = false
    }
    
    func enabledButtons() {
        softBoiledBtn.isEnabled = true
        inAPouchBtn.isEnabled = true
        hardBoiledBtn.isEnabled = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        softBoiledBtn.isHighlighted = true //тень
        inAPouchBtn.isHighlighted = true
        selectedType[2] = true //выбрана кнопка
        timerLabel.text = NSString(format: "%0.2d:%0.2d", hardBoiledConst/60, hardBoiledConst%60) as String
    }
    
    func getCurrentTimer() -> Int {
        if selectedType[0] {
            return softBoiledConst
        } else if selectedType[1] {
            return inAPouchConst
        } else {
            return hardBoiledConst
        }
    }
    
    func setHighlightingForButtons() {
        if selectedType[0] {
            softBoiledBtn.isHighlighted = false
            inAPouchBtn.isHighlighted = true
            hardBoiledBtn.isHighlighted = true
        } else if selectedType [1] {
            softBoiledBtn.isHighlighted = true
            inAPouchBtn.isHighlighted = false
            hardBoiledBtn.isHighlighted = true
        } else {
            softBoiledBtn.isHighlighted = true
            inAPouchBtn.isHighlighted = true
            hardBoiledBtn.isHighlighted = false
        }
    }


}


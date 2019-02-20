//
//  ViewController.swift
//  WatchDemo
//
//  Created by tbago on 2019/2/20.
//  Copyright © 2019年 tbago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    
    var timer:Timer!
    var currentNumber = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func startButtonClick() {
        if self.timer != nil {
            self.endButtonClick()
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
            self.currentNumber += 0.1
            self.numberLabel.text = String(format: "%.1f", self.currentNumber)
        })
        self.timer.fire()
    }
    
    @IBAction func endButtonClick() {
        guard let timerForDestory = self.timer else {
            return
        }
        timerForDestory.invalidate()
    }
    
    @IBAction func resetButtonClick() {
        self.currentNumber = 0;
        self.numberLabel.text = "0"
    }
    
}


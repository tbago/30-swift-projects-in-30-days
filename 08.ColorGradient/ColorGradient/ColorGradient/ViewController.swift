//
//  ViewController.swift
//  ColorGradient
//
//  Created by tbago on 2019/2/28.
//  Copyright © 2019年 tbago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    let brightestSkyColorR = 21.0
    let brightestSkyColorG = 105.0
    let brightestSkyColorB = 203.0
    
    let darkestSkyColorR = 8.0
    let darkestSkyColorG = 33.0
    let darkestSkyColorB = 63.0
    
    let highestTemperatureColorR = 255.0
    let highestTemperatureColorG = 200.0
    let highestTemperatureColorB = 101.0
    
    let lowestTemperatureColorR = 47.0
    let lowestTemperatureColorG = 169.0
    let lowestTemperatureColorB = 199.0
    
    let lowestTemperature = 18
    let highestTemperature = 41
    
    var colorSets = [[CGColor]]()
    var currentColorSet: Int!
    var totalIndex = 0
    var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createColorSet()
        
        createGradientLayer()
    }
    
    var lastY:CGFloat = 0.0
    var lastTotalIndex = 0
    var deltaOrigin = 0
    var indexForUp = 0
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: self.view)
        let tranY = sender.translation(in: self.view).y
        if lastY == 0 || tranY * lastY < 0{
            lastY = tranY
            lastTotalIndex = totalIndex
        }
        let scopeY = self.view.frame.height / 24.0
        //        time ++ up to down
        if velocity.y > 0 && totalIndex < 23{
            totalIndex = Int((tranY - lastY) /  scopeY)
            if totalIndex == 0 {
                deltaOrigin = lastTotalIndex
            }
            totalIndex += deltaOrigin
            lastTotalIndex = totalIndex
            //            print("time++ : index-> \(totalIndex)")
        }
        
        //        time -- down to up
        if velocity.y < 0 && totalIndex > 1{
            indexForUp = Int((tranY - lastY) / scopeY)
            if indexForUp == 0 {
                deltaOrigin = lastTotalIndex
            }
            totalIndex = deltaOrigin + indexForUp
            lastTotalIndex = totalIndex
        }
        changeColor()
        changeLabel()
    }
    
    func changeColor() {
        guard lastTotalIndex > 0 && lastTotalIndex < 24 else {
            return
        }
        if lastTotalIndex < 12 {
            gradientLayer.colors = colorSets[lastTotalIndex]
        }
        else {
            gradientLayer.colors = colorSets[23 - lastTotalIndex]
        }
    }
    
    func changeLabel() {
        guard lastTotalIndex > 0 && lastTotalIndex < 25 else {
            return
        }
        if lastTotalIndex < 12 {
            temperatureLabel.text = "\(lowestTemperature + lastTotalIndex)°C"
        }
        else {
            temperatureLabel.text = "\(highestTemperature - lastTotalIndex)°C"
        }
        
        timeLabel.text = "\(lastTotalIndex):00"
    }
    
    func createColorSet() {
        for index in 1...12 {
            colorSets.append(createColorSet(index:Double(index)))
        }
        currentColorSet = 0
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = colorSets[currentColorSet]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func createColorSet(index: Double) ->Array<CGColor> {
        let skyR = darkestSkyColorR + (brightestSkyColorR - darkestSkyColorR) * (index - 1) / 11.0
        let skyG = darkestSkyColorG + (brightestSkyColorG - darkestSkyColorG) * (index - 1) / 11.0
        let skyB = darkestSkyColorB + (brightestSkyColorB - darkestSkyColorB) * (index - 1) / 11.0
        
        let temperatureR = lowestTemperatureColorR + (highestTemperatureColorR - lowestTemperatureColorR) * (index - 1) / 11.0
        let temperatureG = lowestTemperatureColorG + (highestTemperatureColorG - lowestTemperatureColorG) * (index - 1) / 11.0
        let temperatureB = lowestTemperatureColorB + (highestTemperatureColorB - lowestTemperatureColorB) * (index - 1) / 11.0
        return [UIColor(red: CGFloat(skyR/255.0), green: CGFloat(skyG/255.0), blue: CGFloat(skyB/255.0), alpha: 1.0).cgColor,
                UIColor(red: CGFloat(temperatureR/255.0), green: CGFloat(temperatureG/255.0), blue: CGFloat(temperatureB/255.0), alpha: 1.0).cgColor]
    }
}


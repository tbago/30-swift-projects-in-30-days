//
//  ViewController.swift
//  CustomFont
//
//  Created by tbago on 2019/2/20.
//  Copyright © 2019年 tbago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printAllSupportedFontNames()
    }
    
    @IBAction func changeFontButtonClick(_ sender: UIButton) {
        ///< https://learnappmaking.com/random-numbers-swift/
        let familyNames = UIFont.familyNames
        let familyName = familyNames.randomElement()!
        
        let fontNames = UIFont.fontNames(forFamilyName: familyName)
        var fontName:String
        if fontNames.isEmpty {
            fontName = familyName
        } else {
            fontName = fontNames.randomElement()!
        }
        
        label.font = UIFont(name: fontName, size: 30)
        
        print("set label font \(fontName)")
    }
    
    func printAllSupportedFontNames() {
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            print("++++++ \(familyName)")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print("------ \(fontName)")
            }
        }
    }
}


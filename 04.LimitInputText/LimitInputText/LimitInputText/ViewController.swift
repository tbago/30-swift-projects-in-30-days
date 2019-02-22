//
//  ViewController.swift
//  LimitInputText
//
//  Created by tbago on 2019/2/22.
//  Copyright © 2019年 tbago. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var limitCountLabel: UILabel!
    @IBOutlet weak var limitCountLabelBottomConstraint: NSLayoutConstraint!
    
    let kLimitCount = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        limitCountLabel.text = String(kLimitCount)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    func textViewDidChange(_ textView: UITextView) {
        let currentCharactorCount = (textView.text?.count)
        if (currentCharactorCount! >= kLimitCount) {
            textView.resignFirstResponder()
        }
        
        limitCountLabel.text = "\(kLimitCount - currentCharactorCount!)"
    }
    
    @objc func keyboardWillChangeFrame(notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let yPostion = endFrame.origin.y;
        let margin = UIScreen.main.bounds.height - yPostion;
        UIView.animate(withDuration: duration) {
            if (margin > 0) {
                self.limitCountLabelBottomConstraint.constant = margin
            }
            else {
                self.limitCountLabelBottomConstraint.constant = 40;
            }
            self.view.layoutIfNeeded()
        }
    }
}


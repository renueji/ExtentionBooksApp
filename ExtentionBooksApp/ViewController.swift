//
//  ViewController.swift
//  ExtentionBooksApp
//
//  Created by Rentaro on 2020/04/01.
//  Copyright © 2020 Rentaro. All rights reserved.
//

import TransitionButton
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: TransitionButton!
    @IBOutlet weak var button2: TransitionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.backgroundColor = .red
        button1.setTitle("button", for: .normal)
        button1.cornerRadius = 60
        
        button1.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        button2.backgroundColor = .red
        button2.setTitle("button", for: .normal)
        button2.cornerRadius = 60
        
        button2.addTarget(self, action: #selector(button2Action(_:)), for: .touchUpInside)
        
    }
    
    
    
    @IBAction func buttonAction(_ sender: Any) {
        
        button1.startAnimation() // 2: Then start the animation when the user tap the button
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                
                sleep(1) // 3: Do your networking task or background work here.
                
                DispatchQueue.main.async(execute: { () -> Void in
                    // 4: Stop the animation, here you have three options for the `animationStyle` property:
                    // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                    // .shake: when you want to reflect to the user that the task did not complete successfly
                    // .normal
                    self.button1.stopAnimation(animationStyle: .expand, completion: {
                        self.performSegue(withIdentifier: "toSecond", sender: nil)
                    })
                })
            })
    }
    

    @IBAction func button2Action(_ sender: Any) {
        
        button2.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass2 = DispatchQoS.QoSClass.background
        let backgroundQueue2 = DispatchQueue.global(qos: qualityOfServiceClass2)
        backgroundQueue2.async(execute: {
            
            sleep(1) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                self.button2.stopAnimation(animationStyle: .expand, completion: {
                    self.performSegue(withIdentifier: "toThird", sender: nil)
                })
            })
        })
    }
    
}

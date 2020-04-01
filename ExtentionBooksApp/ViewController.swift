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
    
    let stackView = UIStackView()
    let button1 = TransitionButton()
    let button2 = TransitionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button1)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        button1.backgroundColor = .red
        button1.setTitle("button", for: .normal)
        button1.cornerRadius = 20
        button1.spinnerColor = .white
        
        button2.backgroundColor = .red
        button2.setTitle("button", for: .normal)
        button2.cornerRadius = 20
        button2.spinnerColor = .white
        
        button1.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        
    }
    
    @IBAction func buttonAction(_ button: TransitionButton) {
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
                button.stopAnimation(animationStyle: .expand, completion: {
                    self.performSegue(withIdentifier: "toSecond", sender: nil)
                })
            })
        })
    }
    }

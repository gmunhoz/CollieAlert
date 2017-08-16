//
//  ViewController.swift
//  CollieAlert
//
//  Created by gmunhoz on 07/20/2017.
//  Copyright (c) 2017 gmunhoz. All rights reserved.
//

import UIKit
import CollieAlert

class ViewController: UIViewController {

    let exampleMessage = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam dui erat, elementum sit amet nulla et, dictum sollicitudin libero. Nulla egestas metus vitae finibus consequat. Cras sollicitudin eros sit amet fermentum congue. Aenean at mattis orci. Duis volutpat leo et sem hendrerit mattis."

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showBasicMessage(_ sender: Any) {
        CollieAlert.show(message: exampleMessage)
    }
    
    @IBAction func showBlurredMessage(_ sender: Any) {
        CollieAlert.show(message: exampleMessage, style: .blurred(style: .light))
    }

}

private extension ViewController {

    func setupGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        imageView.isUserInteractionEnabled = true
    }

    @objc func imageTapped() {
        print("Tapped!")
    }

}


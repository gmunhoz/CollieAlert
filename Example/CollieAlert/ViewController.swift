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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showBasicMessage(_ sender: Any) {
        CollieAlert.show(message: "Mensagem para testar o tamanho do texto no alerta. Vamos ver se vai ficar legal.")
    }
    
    @IBAction func showBlurredMessage(_ sender: Any) {
        
        CollieAlert.show(message: "Mensagem para testar o tamanho do texto no alerta. Vamos ver se vai ficar legal.", blurred: true)
    }
}


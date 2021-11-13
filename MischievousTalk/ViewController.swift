//
//  ViewController.swift
//  MischievousTalk
//
//  Created by Lisbeth Bispo on 07/09/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mischievousTalk = MischievousTalkEntry()
        mischievousTalk.noun = "Eva Green"
        mischievousTalk.adjective = "fatale"
        mischievousTalk.verb = "kills"
        mischievousTalk.number = 1
        
        print(mischievousTalk)
    }


}


//
//  ViewController.swift
//  Color Maker
//
//  Created by Guilherme Silva on 01/08/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redControl: UISlider!
    @IBOutlet weak var greenControl: UISlider!
    @IBOutlet weak var blueControl: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        valueDidChanged()
    }
    
    @IBAction func valueDidChanged() {
        colorView.backgroundColor = UIColor
            .init(red: CGFloat.init(redControl.value),
                  green: CGFloat.init(greenControl.value),
                  blue: CGFloat.init(blueControl.value),
                  alpha: 1)
    }
}


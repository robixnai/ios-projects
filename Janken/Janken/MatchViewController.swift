//
//  ViewController.swift
//  Janken
//
//  Created by Guilherme Silva on 02/08/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! ResultsViewController
        
        if let tag = sender as! Int?, jankenOption = JankenOption(rawValue: tag) {
            controller.selectedJankenOption = jankenOption
        }
    }

    @IBAction func didSelectButton(sender: UIButton) {
        performSegueWithIdentifier("resultsController", sender: sender.tag)
    }

}


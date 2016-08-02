//
//  ResultsViewController.swift
//  Janken
//
//  Created by Guilherme Silva on 02/08/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var cpuOptionImageView: UIImageView!
    @IBOutlet weak var youOptionImageView: UIImageView!
    
    
    var selectedJankenOption: JankenOption!
    var itsATie = false
    var paperCoversRock = false
    var rockCrushesScissors = false
    var scissorsCutPaper = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomValue = Int(arc4random_uniform(3))
        if let randomOption = JankenOption(rawValue: Int(randomValue)) {
            checkConditions(randomOption)//randomOption)
            
            configureOptionImageView(cpuOptionImageView, jankenOption: randomOption)// randomOption)
            configureOptionImageView(youOptionImageView, jankenOption: selectedJankenOption)
        }
    }

    func checkConditions(cpuOption: JankenOption) {
        self.itsATie = cpuOption == self.selectedJankenOption ? true : false
        
        self.rockCrushesScissors = cpuOption == .Rock && self.selectedJankenOption == .Scissors ? true : false
        if !self.rockCrushesScissors {
            self.rockCrushesScissors = cpuOption == .Scissors && self.selectedJankenOption == .Rock ? true : false
        }
        
        self.paperCoversRock = cpuOption == .Rock && self.selectedJankenOption == .Paper ? true : false
        if !self.paperCoversRock {
            self.paperCoversRock = cpuOption == .Paper && self.selectedJankenOption == .Rock ? true : false
        }
        
        self.scissorsCutPaper = cpuOption == .Paper && self.selectedJankenOption == .Scissors ? true : false
        if !self.scissorsCutPaper {
            self.scissorsCutPaper = cpuOption == .Scissors && self.selectedJankenOption == .Paper ? true : false
        }
        
        configureViews()
    }
    
    func configureViews() {
        if itsATie {
            resultImageView.image = UIImage.init(named: "itsATie")
            captionLabel.text = "It's a tie!"
        } else if (paperCoversRock){
            resultImageView.image = UIImage.init(named: "PaperCoversRock")
            captionLabel.text = "Paper covers Rock"
        } else if (rockCrushesScissors){
            resultImageView.image = UIImage.init(named: "RockCrushesScissors")
            captionLabel.text = "Rock crushes Scissors"
        } else if (scissorsCutPaper){
            resultImageView.image = UIImage.init(named: "ScissorsCutPaper")
            captionLabel.text = "Scissors Cut Paper"
        }
    
    }
    
    func configureOptionImageView(imageView: UIImageView, jankenOption: JankenOption) {
        var image: UIImage?
        switch jankenOption {
            case .Scissors:
                image = UIImage(named: "scissors")
            case .Rock:
                image = UIImage(named: "rock")
            case .Paper:
                image = UIImage(named: "paper")
        }
        
        if let image = image {
            imageView.image = image
        }
    }
    
    @IBAction func playAgain() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

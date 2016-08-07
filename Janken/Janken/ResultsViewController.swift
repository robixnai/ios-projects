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
    var cpuWon = false
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
            self.cpuWon = false
        } else {
            self.cpuWon = true
        }
        
        self.paperCoversRock = cpuOption == .Rock && self.selectedJankenOption == .Paper ? true : false
        if !self.paperCoversRock {
            self.paperCoversRock = cpuOption == .Paper && self.selectedJankenOption == .Rock ? true : false
            self.cpuWon = false
        } else {
            self.cpuWon = true
        }
        
        self.scissorsCutPaper = cpuOption == .Paper && self.selectedJankenOption == .Scissors ? true : false
        if !self.scissorsCutPaper {
            self.scissorsCutPaper = cpuOption == .Scissors && self.selectedJankenOption == .Paper ? true : false
            self.cpuWon = false
        } else {
            self.cpuWon = true
        }
        
        configureViews()
    }
    
    func configureViews() {
        var resultString: String?
        var tieString: String?

        if itsATie {
            resultImageView.image = UIImage.init(named: "itsATie")
            tieString = "It's a tie!"
            captionLabel.text = tieString
        } else if (paperCoversRock){
            resultImageView.image = UIImage.init(named: "PaperCoversRock")
            resultString = "Paper covers Rock"
            captionLabel.text = resultString
        } else if (rockCrushesScissors){
            resultImageView.image = UIImage.init(named: "RockCrushesScissors")
            resultString = "Rock crushes Scissors"
            captionLabel.text = resultString
        } else if (scissorsCutPaper){
            resultImageView.image = UIImage.init(named: "ScissorsCutPaper")
            resultString = "Scissors Cut Paper"
            captionLabel.text = resultString
        }
        
        if let tie = tieString {
            saveUserDefaults("Tie", detailText: tie)
        } else if let result = resultString {
            if self.cpuWon {
                saveUserDefaults("Won", detailText: result)
            } else {
                saveUserDefaults("Lost", detailText: result)
            }
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
    
    func saveUserDefaults(titleText: String, detailText: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var historyDefaults = defaults.arrayForKey("history")
        
        if historyDefaults == nil {
            historyDefaults = []
        }
        
        historyDefaults!.append(["title": titleText, "detail": detailText])
        defaults.setObject(historyDefaults, forKey: "history")
    }
    
    @IBAction func playAgain() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

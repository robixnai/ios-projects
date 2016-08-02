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
    var itsATie: Bool?
    var paperCoversRock: Bool?
    var rockCrushesScissors: Bool?
    var scissorsCutPaper: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomValue = Int(arc4random_uniform(2))
        if let randomOption = JankenOption(rawValue: Int(randomValue)) {
            checkConditions(randomOption)
            
            configureOptionImageView(cpuOptionImageView, jankenOption: randomOption)
            configureOptionImageView(youOptionImageView, jankenOption: selectedJankenOption)
        }
    }

    func checkConditions(cpuOption: JankenOption) {
        itsATie = cpuOption == selectedJankenOption ? true : nil
        rockCrushesScissors = cpuOption == .Rock && selectedJankenOption == .Scissors ? true : nil
        paperCoversRock = cpuOption == .Paper && selectedJankenOption == .Rock ? true : nil
        scissorsCutPaper = cpuOption == .Scissors && selectedJankenOption == .Paper ? true : nil
        
        rockCrushesScissors = selectedJankenOption == .Rock && cpuOption == .Scissors ? true : nil
        paperCoversRock = selectedJankenOption == .Paper && cpuOption == .Rock ? true : nil
        scissorsCutPaper = selectedJankenOption == .Scissors && cpuOption == .Paper ? true : nil
        
        configureViews()
    }
    
    func configureViews() {
        if itsATie != nil {
            resultImageView.image = UIImage.init(named: "itsATie")
            captionLabel.text = "It's a tie!"
        } else if (paperCoversRock != nil){
            resultImageView.image = UIImage.init(named: "PaperCoversRock")
            captionLabel.text = "Paper covers Rock"
        } else if (rockCrushesScissors != nil){
            resultImageView.image = UIImage.init(named: "RockCrushesScissors")
            captionLabel.text = "Rock crushes Scissors"
        } else if (scissorsCutPaper != nil){
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

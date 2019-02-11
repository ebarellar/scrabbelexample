//
//  ViewController.swift
//  Scrabble
//
//  Created by Trabajo on 2/11/19.
//  Copyright © 2019 Trabajo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var wordStack: UIStackView!
    @IBOutlet var lettersStack: UIStackView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var stateLabel: UILabel!
    var gameOVer = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func changeWord(_ sender: Any) {
        guard let word = textField.text else {  return }
        let characters = Array(word)
        let lettersArray = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        guard characters.count > 2 else {return}
        
        stateLabel.text = "Game on"
        view.endEditing(true)
        gameOVer = false
        for view in wordStack.subviews{
            view.removeFromSuperview()
        }
        
        for character in characters{
            let label = UILabel()
            label.text = String(character)
            label.alpha = 0
            wordStack.addArrangedSubview(label)
        }
        wordStack.arrangedSubviews[0].alpha = 1
         wordStack.arrangedSubviews[characters.count - 1].alpha = 1
        
        for view in lettersStack.arrangedSubviews{
            view.removeFromSuperview()
        }
        
        //Real letters
        for index in 1..<characters.count - 1{
            let button = UIButton(type: .system)
            button.setTitle(String(characters[index]), for: .normal)
            button.addTarget(self, action: #selector(tapFunction(sender:)), for: .touchUpInside)
            lettersStack.addArrangedSubview(button)
        }
        
        //Random letters
        for _ in 1...5{
            let button = UIButton(type: .system)
            let letter = lettersArray.randomElement()
            button.setTitle(String(letter!), for: .normal)
            button.addTarget(self, action: #selector(tapFunction(sender:)), for: .touchUpInside)
            lettersStack.addArrangedSubview(button)
        }
        
        
    }
    
    @objc
    func tapFunction(sender:UIButton) {
        let letterButton = sender
    
        for view in wordStack.arrangedSubviews{
            guard let label = view as? UILabel else {return}
            guard label.alpha == 0 else { continue }//Only hidden leters
            if letterButton.titleLabel?.text == label.text{
                label.alpha = 1
                letterButton.removeFromSuperview()
                break
            }
        }
        
        //Check if game is over
        
        gameOVer = true
        for view in wordStack.arrangedSubviews{
            if view.alpha == 0{
                gameOVer = false
                break
            }
        }
        
        if gameOVer{
            stateLabel.text = String("Game over")
        }
    }
    

    
}


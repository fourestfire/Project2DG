//
//  ViewController.swift
//  Project2DG
//
//  Created by Dean Guo on 10/23/16.
//  Copyright © 2016 fourestfire. All rights reserved.
//

// adding Gameplaykit to use built in game frameworks
import GameplayKit
import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var currentscore: UILabel!
    
    var countries = [String]()
    var score = 0
    // Which flag is correct?
    var correctAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        // Have to put it inside the function - it's not a property)
         countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // Makes it so that there's a black border. automatically translates the border to the right number of pixels for the device in question. It should look the same on any device.
        // This is done using CALayer, which is a Core Animation data type responsible for managing how the view looks.
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.darkGray.cgColor
        button2.layer.borderColor = UIColor.darkGray.cgColor
        button3.layer.borderColor = UIColor.darkGray.cgColor
        
        // Can also specify color like this: UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        
        // Passes the parameter nil to the askQuestion during initialization
        askQuestion(action: nil)
        
    }
    
    func askQuestion(action: UIAlertAction!) {
        // This part shuffles the order of the countries int he array
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        // Sets image for the button
        // Buttons have 3 states - normal, highlighted, disabled
        // enum allows us to use .normal instead of states as 0, 1, and 2 so that it's easier to use and follow
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        //Select a random correct answer using the GameplayKit framework
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        // Ask the question in the title based on which country was set as the correctAnswer
        let country = countries[correctAnswer].uppercased()
        title = "Which flag is from " + country + "?"
    
    }
    
    // Dragged button1 from storyboard and set as Action. Dragged button2 and 3 as well.
    // IBAction lets button trigger code, and IBOutlet lets code affect UI.
    // In the storyboard, flags were tagged as 0, 1, and 2 in attributes screen, to differentiate between which flag was pressed.
    // This method needs to 1. Check whether the answer was correct, 2. Adjust the player's score up or down, and 3. Tell them what their new score is.
    @IBAction func buttonTapped(_ sender: UIButton) {
       
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
            currentscore.text = "Current Score: " + String(score)
        } else {
             title = "Incorrect."
            score -= 1
            currentscore.text = "Current Score: " + String(score)
        }
        
        // Display alert after selection (preferred style as alert, vs actionSheet, which slides up from the bottom (should be used for actions))
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        
        // styles: .default, .cancel, and .destructive
        // The handler parameter is looking for a closure, which is some code that it can execute when the button is tapped. You can write custom code in there if you want, but in our case we want the game to continue when the button is tapped, so we pass in askQuestion so that iOS will call our askQuestion() method. 
        // Warning: We must use askQuestion and not askQuestion(). If you use the former, it means "here's the name of the method to run," but if you use the latter it means "run the askQuestion() method now, and it will tell you the name of the method to run."
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        // The final line calls present(), which takes two parameters: a view controller to present and whether to animate the presentation. Has a third parameter that takes another closure, but we aren't using it
        present(ac, animated: true)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


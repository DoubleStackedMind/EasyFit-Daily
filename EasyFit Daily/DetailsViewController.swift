//
//  DetailsViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 4/23/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import PreviewTransition
import CoreMotion

var WorkoutType:String = ""

class DetailsViewController: PTDetailViewController {

    
    
    @IBOutlet var GoTo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoTo.setTitle(WorkoutType + " >", for: .normal)
        let HCV = HomeViewController()
        HCV.startUpdating()
        HCV.startCountingSteps()
        // Do any additional setup after loading the view.
    }
    
    func backButtonHandler() {
        popViewController()
    }

   
    @IBAction func GoToAction(_ sender: Any) {
        if(GoTo.titleLabel?.text == "Gym Workout >") {
            performSegue(withIdentifier: "GoToGym", sender: nil)
        }
        if(GoTo.titleLabel?.text == "Yoga >") {
            performSegue(withIdentifier: "GoToYoga", sender: nil)
        }
        if(GoTo.titleLabel?.text == "Calories Burned >") {
            performSegue(withIdentifier: "GoToCalories", sender: nil)
        }
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

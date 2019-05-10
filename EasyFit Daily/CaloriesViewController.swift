//
//  CaloriesViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 10/05/2019.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit

class CaloriesViewController: ViewController {

    @IBOutlet weak var stepsMade: UILabel!
    @IBOutlet weak var stepsAtRest: UILabel!
    @IBOutlet weak var CaloriesBurned: UILabel!
    
     let HCV = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HCV.startUpdating()
        HCV.startCountingSteps()
        
        CaloriesBurned.text = String(Double((HCV.stepsCount + HCV.StepsRunning)) * 0.05)
        stepsMade.text = String(HCV.stepsCount)
        stepsAtRest.text = String(HCV.StepsRunning)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func GoToHome(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

//
//  SignUpController.swift
//  EasyFit Daily
//
//  Created by Ahmed amine on 4/24/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeMe(_ sender: Any) {
        self.dismiss(animated: true
            , completion: nil)
    }
    
    @IBAction func takeMeBackToSignIn(_ sender: Any) {
        self.dismiss(animated: true
            , completion: nil)
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

//
//  SignUpController.swift
//  EasyFit Daily
//
//  Created by Ahmed amine on 4/24/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var DOB: UITextField!
    
    private var DateOB: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateOB = UIDatePicker()
        DateOB?.datePickerMode = .date
        DateOB?.addTarget(self
            , action: #selector(SignUpController.dateChanged(datePicker:))
            , for: .valueChanged)
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        DOB.inputView = DateOB
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        DOB.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(false)
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

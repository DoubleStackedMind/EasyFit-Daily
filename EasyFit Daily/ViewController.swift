//
//  ViewController.swift
//  EasyFit Daily
//
//  Created by Ahmed amine on 4/5/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let global_url="http://172.19.19.249/EasyFitDailyWebService/web/app_dev.php/"
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        }

    @IBAction func SignUpButton(_ sender: Any) {
         let url = global_url+"user/retrieve"
        
        let parameters: Parameters = ["username":usernameTextField.text!,"password":passwordTextField.text!]
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default,headers: nil).validate(contentType: ["application/json"]).responseJSON() {
            response in
            
            switch response.result {
            case .success:
                  let userArray = (response.result.value  as! NSArray)
                  for user in userArray {
                    let userDict = user as! Dictionary<String,Any>
                  
                  if(self.usernameTextField.text == userDict["email"] as! String && self.passwordTextField.text == userDict["password"] as! String){
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                  }
                    
                  else
                    {
                        let NameAlertController = UIAlertController(title: "Alert", message: "Username or password is incorrect!", preferredStyle: .alert)
                        let NameAlertAction = UIAlertAction(title: "OK", style: .default)
                        NameAlertController.addAction(NameAlertAction)
                        self.present(NameAlertController, animated: true, completion: nil)
                    }
                     }
                 
                
                break
            case .failure(let error):
                let NameAlertController = UIAlertController(title: "Alert", message: "Username or password is incorrect!", preferredStyle: .alert)
                let NameAlertAction = UIAlertAction(title: "OK", style: .default)
                NameAlertController.addAction(NameAlertAction)
                self.present(NameAlertController, animated: true, completion: nil)
              
                break
                }
        }
    }
}
    

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UITextField {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
}
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
}



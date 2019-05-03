//
//  SignUpController.swift
//  EasyFit Daily
//
//  Created by Ahmed amine on 4/24/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import Alamofire

class SignUpController: UIViewController {

    let global_url="http://172.19.19.249/EasyFitDailyWebService/web/app_dev.php/"
    let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
    let set2 = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ123456789 ")
    let datePicker = UIDatePicker()
    var timestamp:CLongLong = 0
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var birthdateTextField: UITextField!
    
    var name:String = ""
    var username:String = ""
    var password:String = ""
    var confirmPassword:String = ""
    var email:String = ""
    var birthdate:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
        var checkName = false
        var checkUsername = false
        var checkPasswords = false
        var checkEmail = false
        var checkAge = false
        if(!(nameTextField.isValid())) {
            print("Name not valid")
            
            let NameAlertController = UIAlertController(title: "Alert", message: "Name is  invalid, name must only contain letters and white spaces", preferredStyle: .alert)
            let NameAlertAction = UIAlertAction(title: "OK", style: .default)
            NameAlertController.addAction(NameAlertAction)
            self.present(NameAlertController, animated: true, completion: nil)
        } else {
            checkName=true
            name = nameTextField.text!
        }
        
        if(!usernameTextField.isNotEmptyAndValid()) {
            print("Username not valid")
            
            let NameAlertController = UIAlertController(title: "Alert", message: "Username is  invalid, Username must only contain letters and numbers ", preferredStyle: .alert)
            let NameAlertAction = UIAlertAction(title: "OK", style: .default)
            NameAlertController.addAction(NameAlertAction)
            self.present(NameAlertController, animated: true, completion: nil)
        } else {
            checkUsername = true
            username = usernameTextField.text!
        }
        
        if(passwordTextField.text != confirmPasswordTextField.text || confirmPasswordTextField.text == "" ) {
            print("Password does not match")
            
            let NameAlertController = UIAlertController(title: "Alert", message: "Please confirm your password correctly!", preferredStyle: .alert)
            let NameAlertAction = UIAlertAction(title: "OK", style: .default)
            NameAlertController.addAction(NameAlertAction)
            self.present(NameAlertController, animated: true, completion: nil)
        } else if(passwordTextField.text == "") {
            print("Enter a password")
            
            let NameAlertController = UIAlertController(title: "Alert", message: "Please type your password!", preferredStyle: .alert)
            let NameAlertAction = UIAlertAction(title: "OK", style: .default)
            NameAlertController.addAction(NameAlertAction)
            self.present(NameAlertController, animated: true, completion: nil)
        } else {
            checkPasswords = true
            password = passwordTextField.text!
        }
        if(!EmailTextField.isValidEmail()) {
            print("Email is not valid")
            
            let NameAlertController = UIAlertController(title: "Alert", message: "Please enter a valid email address!", preferredStyle: .alert)
            let NameAlertAction = UIAlertAction(title: "OK", style: .default)
            NameAlertController.addAction(NameAlertAction)
            self.present(NameAlertController, animated: true, completion: nil)
        } else {
            checkEmail = true
            email = EmailTextField.text!
            
        }
        if(!birthdateTextField.isOld()){
            print("You must be older than 12")
            
            let NameAlertController = UIAlertController(title: "Alert", message: "You must be older than 12 years old!", preferredStyle: .alert)
            let NameAlertAction = UIAlertAction(title: "OK", style: .default)
            NameAlertController.addAction(NameAlertAction)
            self.present(NameAlertController, animated: true, completion: nil)
        } else {
            checkAge = true
            birthdate =  birthdateTextField.text!
            print(timestamp)
            print("&&&&&&&&&&&&&& " + birthdate)
        }
        if(checkName && checkUsername && checkEmail && checkPasswords && checkAge) {
            let parameters: Parameters = ["name":name,"username":username,"password":password,"email":email,"birthdate":timestamp]
            
            let url = global_url+"user/new"
            Alamofire.request(url,method:.post,parameters:parameters,encoding:URLEncoding(destination: .queryString),headers:nil).responseString {
                response in
                switch response.result {
                case .success:
                    print(response)
                    self.performSegue(withIdentifier: "toMain", sender: nil)
                    break
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            print("sign up failed")
        }
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

    func createDatePicker(){
        
        //format for datepicker display
        datePicker.datePickerMode = .date
        
        //assign datepicker to our textfield
        birthdateTextField.inputView = datePicker
        
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        toolbar.setItems([doneButton], animated: true)
        
        birthdateTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(){
        
        //format for displaying the date in our textfield
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.timestamp = (CLongLong(datePicker.date.timeIntervalSince1970 * 1000))
        birthdateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
}
extension UITextField {
    
    public func isValid() -> Bool {
        var nameValue: String = self.text!
        if(nameValue == "") {
            return false
        }
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: nameValue, options: [], range: NSMakeRange(0, nameValue.characters.count)) != nil {
                return false
                
            } else {
                return true
            }
        }
        catch {
            
        }
        return false
    }
    
    public func isNotEmptyAndValid() -> Bool {
        var value: String = self.text!
        if(value == "") {
            return false
        }
        if(value == " ") {
            return false
        }
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z1-9].*", options: [])
            if regex.firstMatch(in: value, options: [], range: NSMakeRange(0, value.characters.count)) != nil {
                return false
                
            } else {
                return true
            }
        }
        catch {
            
        }
        return false
    }
    
    func isValidEmail() -> Bool {
    
        var testString = self.text!
        if(testString == "") {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testString)
    }
    
    func isOld() -> Bool {
        var value = self.text!
        if(value != "") {
            return true
        }
    return false
    }
}


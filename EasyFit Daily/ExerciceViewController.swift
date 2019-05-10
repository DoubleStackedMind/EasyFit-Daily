//
//  ExerciceViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 10/05/2019.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import Alamofire

class ExerciceViewController: UIViewController {

    let global_url="http://172.19.19.249/EasyFitDailyWebService/web/app_dev.php/"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var PauseButton: UIButton!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet weak var SavedTime: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    
    var seconds = 900 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var SavedTimeinSecs = 0
    
    var timer = Timer()
    var resumeTapped = false
    
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PauseButton.isEnabled = false
        timerLabel.text = timeString(time: TimeInterval(seconds))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.StartButton.isEnabled = false
        }
    }
    
    @IBAction func PauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.PauseButton.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            self.PauseButton.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 900    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        PauseButton.isEnabled = false
        
        SavedTime.text = timeString(time: TimeInterval(SavedTimeinSecs))
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        // get the date time String from the date object
        todayDate.text = formatter.string(from: currentDateTime)
        if(SavedTimeinSecs != 0) {
        let parameters: Parameters = ["name":"Dumbell","time":SavedTime.text,"DayOfWeek":todayDate.text,"user_id":1]
        
        let url = global_url+"workout/new"
        Alamofire.request(url,method:.post,parameters:parameters,encoding:URLEncoding(destination: .queryString),headers:nil).responseString {
            response in
            switch response.result {
            case .success:
                print(response)
               // self.performSegue(withIdentifier: "toLogin", sender: nil)
                print("Success !!!!")
                break
            case .failure(let error):
                print(error)
            }
        }
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ExerciceViewController.updateTimer)), userInfo: nil, repeats: true)
        
        isTimerRunning = true
        PauseButton.isEnabled = true
    }
    
    @objc func updateTimer() {
        seconds -= 1 //This will decrement(count down)the seconds.
        SavedTimeinSecs += 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
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

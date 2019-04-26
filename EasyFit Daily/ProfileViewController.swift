//
//  ProfileViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 4/25/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var Name: UILabel!
    
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var Stackview: UIStackView!
    @IBOutlet weak var DateOfBirth: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var ProfilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.dropShadow()
        ProfilePicture.setRounded()
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

}

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
       self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
}
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 6
        
        //layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


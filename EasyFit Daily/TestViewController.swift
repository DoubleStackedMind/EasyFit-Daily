//
//  TestViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 4/23/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import Navigation_stack


class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.interactivePopGestureRecognizer?.delegate = self
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

extension TestViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if navigationController?.viewControllers.count == 2 {
            return true
        }
        
        if let navigationController = self.navigationController as? NavigationStack {
            navigationController.showControllers()
        }
        
        return false
    }
}

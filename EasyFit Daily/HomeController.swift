//
//  HomeController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 4/16/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import Foundation
import Navigation_stack
import UIKit

class HomeController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.interactivePopGestureRecognizer?.delegate = self as! UIGestureRecognizerDelegate
        
    }
}

extension HomeController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if navigationController?.viewControllers.count == 2 {
            return true
        }
        
        if let navigationController = self.navigationController as? NavigationStack {
            navigationController.showControllers()
        }
        
        return false
    }
}

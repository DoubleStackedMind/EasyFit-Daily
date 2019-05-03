//
//  HomeViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 4/23/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import PreviewTransition
import Navigation_stack

class HomeViewController: PTTableViewController {
    
    fileprivate let items = [("1", "Gym Workout"), ("2", "Yoga"), ("3", "Healthy Diet"), ("4", "Southern Coast"), ("5", "Fishing place")] // image names
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.interactivePopGestureRecognizer?.delegate = self
    }
    
}

// MARK: UITableViewDelegate
extension HomeViewController {
    
    public override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 5
    }
    
    public override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ParallaxCell else { return }
        
        let index = indexPath.row % items.count
        let imageName = items[index].0
        let title = items[index].1
        
        
        if let image = UIImage(named: imageName) {
            cell.setImage(image, title: title)
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ParallaxCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ParallaxCell
        return cell
    }
    
    public override func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        let DVC = storyboard?.instantiateViewController(withIdentifier: "detailsID")
        if case let viewController as DetailsViewController = DVC {
            pushViewController(viewController)
        }
        let indexPath = tableView.indexPathForSelectedRow//optional, to get from any UIButton for example
        WorkoutType = items[(indexPath?.row)!].1
    }
    
   
    
}

extension HomeViewController: UIGestureRecognizerDelegate {
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

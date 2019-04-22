//
//  HomeTableViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 4/22/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import PreviewTransition

class HomeTableViewController: PTTableViewController {

    fileprivate let items = [("1", "River cruise"), ("2", "North Island"), ("3", "Mountain trail"), ("4", "Southern Coast"), ("5", "Fishing place")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


extension HomeTableViewController {
    
    public override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 100
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
        let cell: ParallaxCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParallaxCell
        return cell
    }
    
    public override func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        let storyboard = UIStoryboard.storyboard(storyboard: .Main)
        let detaleViewController: DetailViewController = storyboard.instantiateViewController()
        pushViewController(detaleViewController)
    }
}


extension UIStoryboard {
    
    enum Storyboard: String {
        case Main
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

extension UIViewController: StoryboardIdentifiable {}

// MARK: identifiable

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    @property(nullable, nonatomic, readonly, strong) UIStoryboard *storyboard NS_AVAILABLE_IOS(5_0);
}

// MARK: identifiable

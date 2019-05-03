//
//  YogaTypesViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 5/3/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import GlidingCollection

class YogaTypesViewController: UIViewController {

    @IBOutlet var GlidingCollection: GlidingCollection!
    
     fileprivate let items = ["Power Yoga", "Spiritual Yoga"]
    fileprivate var collectionView: UICollectionView!
    fileprivate var images: [[UIImage?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    @IBAction func GoBackTo(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}


extension YogaTypesViewController {
    
    func setup() {
        setupGlidingCollectionView()
        loadImages()
    }
    
    private func setupGlidingCollectionView() {
        GlidingCollection.dataSource = self
        
        let nib = UINib(nibName: "CollectionCell", bundle: nil)
        collectionView = GlidingCollection.collectionView
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = GlidingCollection.backgroundColor
    }
    
    private func loadImages() {
        for item in items {
            let imageURLs = FileManager.default.fileUrls(for: "jpg", fileName: item)
            var images: [UIImage?] = []
            for url in imageURLs {
                guard let data = try? Data(contentsOf: url) else { continue }
                let image = UIImage(data: data)
                images.append(image)
            }
            self.images.append(images)
        }
    }
    
}

// MARK: - CollectionView 🎛
extension YogaTypesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = GlidingCollection.expandedItemIndex
        return images[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        let section = GlidingCollection.expandedItemIndex
        let image = images[section][indexPath.row]
        cell.imageView.image = image
        cell.contentView.clipsToBounds = true
        
        let layer = cell.layer
        let config = GlidingConfig.shared
        layer.shadowOffset = config.cardShadowOffset
        layer.shadowColor = config.cardShadowColor.cgColor
        layer.shadowOpacity = config.cardShadowOpacity
        layer.shadowRadius = config.cardShadowRadius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = GlidingCollection.expandedItemIndex
        let item = indexPath.item
        print("Selected item #\(item) in section #\(section)")
    }
    
}

// MARK: - Gliding Collection 🎢
extension YogaTypesViewController: GlidingCollectionDatasource {
    
    func numberOfItems(in collection: GlidingCollection) -> Int {
        return items.count
    }
    
    func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
        return "– " + items[index]
    }
    
}

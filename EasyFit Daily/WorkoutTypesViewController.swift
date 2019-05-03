//
//  WorkoutTypesViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 5/3/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import GlidingCollection

class WorkoutTypesViewController: UIViewController {

    fileprivate let items = ["DumbBells", "BenchPress", "EzCurlBar"]
    
    @IBOutlet var glidingCollection: GlidingCollection!
    fileprivate var collectionView: UICollectionView!
    fileprivate var images: [[UIImage?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func GoToHome(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension WorkoutTypesViewController {
    
    func setup() {
        setupGlidingCollectionView()
        loadImages()
    }
    
    private func setupGlidingCollectionView() {
        glidingCollection.dataSource = self
        
        let nib = UINib(nibName: "CollectionCell", bundle: nil)
        collectionView = glidingCollection.collectionView
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = glidingCollection.backgroundColor
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
extension WorkoutTypesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = glidingCollection.expandedItemIndex
        return images[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        let section = glidingCollection.expandedItemIndex
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
        let section = glidingCollection.expandedItemIndex
        let item = indexPath.item
        print("Selected item #\(item) in section #\(section)")
    }
    
}

// MARK: - Gliding Collection 🎢
extension WorkoutTypesViewController: GlidingCollectionDatasource {
    
    func numberOfItems(in collection: GlidingCollection) -> Int {
        return items.count
    }
    
    func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
        return "– " + items[index]
    }
    
}


extension FileManager {
    
    func fileUrls(for types: String..., fileName: String) -> [URL] {
        let bundlePath = Bundle.main.bundlePath
        let directoryEnumerator = enumerator(atPath: bundlePath)
        
        var paths = [URL]()
        
        while let path = directoryEnumerator?.nextObject() as? String {
            let url = URL(fileURLWithPath: path)
            for type in types {
                if
                    url.path.lowercased().contains(fileName.lowercased())
                        && url.path.contains(type) {
                    let url = Bundle.main.bundleURL.appendingPathComponent(path)
                    paths.append(url)
                }
            }
        }
        
        return paths
    }
    
}

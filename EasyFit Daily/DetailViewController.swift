//
//  DetailViewController.swift
//  EasyFit Daily
//
//  Created by ESPRIT on 4/22/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import UIKit
import PreviewTransition

class DetailViewController: PTDetailViewController {

    
    @IBOutlet var controlBottomConstrant: NSLayoutConstraint!

    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var controlsViewContainer: UIView!
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var controlTextLabel: UILabel!
    @IBOutlet weak var hertIconView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet var controlTextLableLending: NSLayoutConstraint!
    
    var backButton: UIButton?
    
    var bottomSafeArea: CGFloat {
        var result: CGFloat = 0
        if #available(iOS 11.0, *) {
            result = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return result
    }

}


extension DetailViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton = createBackButton()
        _ = createNavigationBarBackItem(button: backButton)
        
        // animations
        showBackButtonDuration(duration: 0.3)
        showControlViewDuration(duration: 0.3)
        
        _ = createBlurView()
    }
}

extension DetailViewController {
    
    fileprivate func createBackButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 44))
        button.setImage(UIImage.init(named: "String"), for: .normal)
        button.addTarget(self, action: #selector(DetailViewController.backButtonHandler), for: .touchUpInside)
        return button
    }
    
    fileprivate func createNavigationBarBackItem(button: UIButton?) -> UIBarButtonItem? {
        guard let button = button else {
            return nil
        }
        
        let buttonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = buttonItem
        return buttonItem
    }
    
    fileprivate func createBlurView() -> UIView {
        let height = controlView.bounds.height + bottomSafeArea
        let imageFrame = CGRect(x: 0, y: view.frame.size.height - height, width: view.frame.width, height: height)
        let image = view.makeScreenShotFromFrame(frame: imageFrame)
        let screnShotImageView = UIImageView(image: image)
        screnShotImageView.blurViewValue(value: 5)
        screnShotImageView.frame = controlsViewContainer.bounds
        screnShotImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controlsViewContainer.insertSubview(screnShotImageView, at: 0)
        addOverlay(toView: screnShotImageView)
        return screnShotImageView
    }
    
    fileprivate func addOverlay(toView view: UIView) {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = .black
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView.alpha = 0.4
        view.addSubview(overlayView)
    }
}

// MARK: animations

extension DetailViewController {
    
    fileprivate func showBackButtonDuration(duration: Double) {
        backButton?.rotateDuration(duration: duration, from: -CGFloat.pi / 4, to: 0)
        backButton?.scaleDuration(duration: duration, from: 0.5, to: 1)
        backButton?.opacityDuration(duration: duration, from: 0, to: 1)
    }
    
    fileprivate func showControlViewDuration(duration: Double) {
        moveUpControllerDuration(duration: duration)
        showControlButtonsDuration(duration: duration)
        showControlLabelDuration(duration: duration)
    }
    
    fileprivate func moveUpControllerDuration(duration: Double) {
        
        controlBottomConstrant.constant = -controlsViewContainer.bounds.height
        view.layoutIfNeeded()
        
        controlBottomConstrant.constant = 0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func showControlButtonsDuration(duration: Double) {
        [plusImageView, shareImageView, hertIconView].forEach {
            $0?.rotateDuration(duration: duration, from: CGFloat.pi / 4, to: 0, delay: duration)
            $0?.scaleDuration(duration: duration, from: 0.5, to: 1, delay: duration)
            $0?.alpha = 0
            $0?.opacityDuration(duration: duration, from: 0, to: 1, delay: duration, remove: false)
        }
    }
    
    fileprivate func showControlLabelDuration(duration: Double) {
        controlTextLabel.alpha = 0
        controlTextLabel.opacityDuration(duration: duration, from: 0, to: 1, delay: duration, remove: false)
        
        // move rigth
        let offSet: CGFloat = 20
        controlTextLableLending.constant -= offSet
        view.layoutIfNeeded()
        
        controlTextLableLending.constant += offSet
        UIView.animate(withDuration: duration * 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: actions

extension DetailViewController {
    
    @objc func backButtonHandler() {
        popViewController()
    }
}


extension UIView {
    
    private func createAnimationFromKey(key: String, duration: Double, from: CGFloat, to: CGFloat, delay: Double = 0, remove: Bool = true) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: key)
        animation.duration = duration
        animation.toValue = to
        animation.fromValue = from
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.beginTime = CACurrentMediaTime() + delay
        if remove == false {
            animation.isRemovedOnCompletion = remove
            animation.fillMode = CAMediaTimingFillMode.forwards
        }
        return animation
    }
    
    func rotateDuration(duration: Double, from: CGFloat, to: CGFloat, delay: Double = 0, remove: Bool = true) {
        let animation = createAnimationFromKey(key: "transform.rotation.z",
                                               duration: duration,
                                               from: from,
                                               to: to,
                                               delay: delay,
                                               remove: remove)
        layer.add(animation, forKey: nil)
    }
    
    func scaleDuration(duration: Double, from: CGFloat, to: CGFloat, delay: Double = 0, remove: Bool = true) {
        let animation = createAnimationFromKey(key: "transform.scale",
                                               duration: duration,
                                               from: from,
                                               to: to,
                                               delay: delay,
                                               remove: remove)
        
        layer.add(animation, forKey: nil)
    }
    
    func opacityDuration(duration: Double, from: CGFloat, to: CGFloat, delay: Double = 0, remove: Bool = true) {
        let animation = createAnimationFromKey(key: "opacity",
                                               duration: duration,
                                               from: from,
                                               to: to,
                                               delay: delay,
                                               remove: remove)
        
        layer.add(animation, forKey: nil)
    }
}

extension UIView {
    
    func makeScreenShotFromFrame(frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: frame.origin.x * -1, y: frame.origin.y * -1)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIImageView {
    
    func blurViewValue(value: CGFloat) {
        guard let image = self.image,
            let blurfilter = CIFilter(name: "CIGaussianBlur"),
            let imageToBlur = CIImage(image: image)
            else {
                return
        }
        
        blurfilter.setValue(value, forKey: kCIInputRadiusKey)
        blurfilter.setValue(imageToBlur, forKey: "inputImage")
        let resultImage = blurfilter.value(forKey: "outputImage") as! CIImage
        var blurredImage = UIImage(ciImage: resultImage)
        let cropped: CIImage = resultImage.cropped(to: CGRect(x: 0, y: 0, width: imageToBlur.extent.size.width, height: imageToBlur.extent.size.height))
        blurredImage = UIImage(ciImage: cropped)
        self.image = blurredImage
    }
}

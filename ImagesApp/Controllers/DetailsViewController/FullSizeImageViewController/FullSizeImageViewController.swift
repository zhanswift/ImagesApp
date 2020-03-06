//
//  FullSizeImageViewController.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/6/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit

class FullSizeImageViewController: UIViewController {
    
    var delegate: FullSizeImageCloseProtocol?
    
    convenience init(image: UIImage, delegateIn: FullSizeImageCloseProtocol) {
        self.init()
        
        delegate = delegateIn
        
        let fullSizeImageView = FullSizeImageView(frame: .zero, image: image)
        fullSizeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fullSizeImageView)
        
        fullSizeImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        fullSizeImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        fullSizeImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        fullSizeImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeAnimate))
        fullSizeImageView.addGestureRecognizer(tap)
        
        showAnimate()
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    @objc func removeAnimate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{ _ in
            self.view.removeFromSuperview()
            self.delegate?.closed()
        })
    }
}

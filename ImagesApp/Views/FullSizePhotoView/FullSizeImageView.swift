//
//  FullSizeImageView.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/6/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit

class FullSizeImageView: UIView {
    
    let photoImageView: UIImageView = {
        let photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        return photoImageView
    }()
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        
        photoImageView.image = image
        
        addSubview(photoImageView)
        
        photoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

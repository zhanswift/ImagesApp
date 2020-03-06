//
//  MyCollectionViewCell.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/5/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    let myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        return photoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        addSubview(photoImageView)
        addSubview(myLabel)
        
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        myLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
    
    func getImage(url: String) {
        NetworkManager.shared.getImage(url: url) { (data, success)  in
            if success {
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: data!)
                }
            }
        }
    }
}

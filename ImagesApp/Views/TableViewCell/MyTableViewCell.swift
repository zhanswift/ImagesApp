//
//  MyTableViewCell.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/5/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    let myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.masksToBounds = true
        return photoImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        addSubview(photoImageView)
        addSubview(myLabel)
        
        let imageViewSize: CGFloat = 110
        
        photoImageView.widthAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        
        photoImageView.layer.cornerRadius = imageViewSize / 2
        
        myLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10).isActive = true
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

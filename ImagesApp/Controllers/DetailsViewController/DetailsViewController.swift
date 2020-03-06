//
//  DetailsViewController.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/5/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var isClosed = true
    
    let myCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return myCollectionView
    }()

    private let reuseIdentifier = "MyDetailVCCell"
    var selectedPhotoAlbum: AlbumModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        self.view.backgroundColor = .white
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.alwaysBounceVertical = true
        myCollectionView.backgroundColor = .white
        myCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.view.addSubview(myCollectionView)
        
        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension DetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NetworkManager.shared.getImage(url: selectedPhotoAlbum.photos[indexPath.row].url) { (data, success) in
            if success && self.isClosed {
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    let fullSizeImageVC: UIViewController = FullSizeImageViewController(image: image!, delegateIn: self)
                    self.addChild(fullSizeImageVC)
                    fullSizeImageVC.view.frame = CGRect(x: 0, y: self.view.center.y / 2, width: self.view.frame.width, height: self.view.frame.width)
                    self.view.addSubview(fullSizeImageVC.view)
                    fullSizeImageVC.didMove(toParent: fullSizeImageVC)
                    self.isClosed = false
                }
            }
        }
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPhotoAlbum.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.myLabel.text = selectedPhotoAlbum.photos[indexPath.row].title
        cell.getImage(url: selectedPhotoAlbum.photos[indexPath.row].thumbnailUrl)
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 3, height: self.view.frame.width / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DetailsViewController: FullSizeImageCloseProtocol {
    func closed() {
        isClosed = true
    }
}

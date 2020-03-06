//
//  MyCollectionViewController.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/5/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController {

    let myCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return myCollectionView
    }()

    private let reuseIdentifier = "MyCollectionVCCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: .getDataFinished, object: nil)
        
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
    
    @objc func reloadCollectionView() {
        myCollectionView.reloadData()
    }
}

extension MyCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailsViewController()
        detailVC.selectedPhotoAlbum = SavedData.shared.photoAlbums[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MyCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SavedData.shared.photoAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        if let title = SavedData.shared.photoAlbums[indexPath.row].photos.first?.title {
            cell.myLabel.text = title
        }
        
        if let thumbnailUrl = SavedData.shared.photoAlbums[indexPath.row].photos.first?.thumbnailUrl {
            cell.getImage(url: thumbnailUrl)
        }
        
        return cell
    }
}

extension MyCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

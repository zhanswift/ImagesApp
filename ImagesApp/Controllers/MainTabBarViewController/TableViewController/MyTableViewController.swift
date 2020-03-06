//
//  TableViewController.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/5/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import UIKit

class MyTableViewController: UIViewController {
        
    var myTableView = UITableView()
    
    private let reuseIdentifier = "MyTableVCCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .getDataFinished, object: nil)
    }
    
    fileprivate func setupView() {
        self.view.backgroundColor = .white
        
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = 120
        myTableView.backgroundColor = .white
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        self.view.addSubview(myTableView)
        
        myTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func reloadTableView() {
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
}

extension MyTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailsViewController()
        detailVC.selectedPhotoAlbum = SavedData.shared.photoAlbums[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MyTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedData.shared.photoAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MyTableViewCell
        
        if let title = SavedData.shared.photoAlbums[indexPath.row].photos.first?.title {
            cell.myLabel.text = title
        }
        
        if let thumbnailUrl = SavedData.shared.photoAlbums[indexPath.row].photos.first?.thumbnailUrl {
            cell.getImage(url: thumbnailUrl)
        }
        
        return cell
    }
    
}

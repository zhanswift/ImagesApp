//
//  NetworkManager.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/5/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {

    private override init() {}
    static let shared = NetworkManager()
    
    func getData(completion: @escaping ([AlbumModel]) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                return
            }
            if data != nil {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String: Any]] {
                        let dict = Dictionary(grouping: json) { $0["albumId"] as! Int }
                        var albumArray = [AlbumModel]()
                        for albumPhoto in dict {
                            var photoArray = [PhotoModel]()
                            for photoItem in albumPhoto.value {
                                let photoId = photoItem["id"] as! Int
                                let photoTitile = photoItem["title"] as! String
                                let photoThumbnailUrl = photoItem["thumbnailUrl"] as! String
                                let photoUrl = photoItem["url"] as! String
                                let photo = PhotoModel(id: photoId, title: photoTitile, thumbnailUrl: photoThumbnailUrl, url: photoUrl)
                                photoArray.append(photo)
                            }
                            let album = AlbumModel(albumId: albumPhoto.key, photos: photoArray.sorted(by: { (first, second) -> Bool in
                                first.id < second.id
                            }))
                            albumArray.append(album)
                            photoArray.removeAll()
                        }
                        completion(albumArray.sorted(by: { (first, second) -> Bool in
                            first.albumId < second.albumId
                        }))
                   }
                } catch let error {
                  print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getImage(url: String, completion: @escaping (Data?, Bool) -> Void) {
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil && data == nil {
                completion(nil, false)
                return
            }
            if data != nil {
                completion(data!, true)
            }
        }.resume()
    }
}

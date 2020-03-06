//
//  AlbumModel.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/5/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import Foundation

class AlbumModel {
    
    let albumId: Int!
    let photos: [PhotoModel]!
    
    init(albumId: Int, photos: [PhotoModel]) {
        self.albumId = albumId
        self.photos = photos
    }
}

//
//  SavedData.swift
//  ImagesApp
//
//  Created by Zhanserik on 3/5/20.
//  Copyright © 2020 Zhanserik. All rights reserved.
//

import Foundation

class SavedData: NSObject {
    
    private override init() {}
    private static var instance: SavedData?
    
    class var shared: SavedData {
        if instance == nil {
            instance = SavedData()
        }
        return instance!
    }
    
    var photoAlbums = [AlbumModel]()
    
    class func destroy() {
        instance = nil
    }
}

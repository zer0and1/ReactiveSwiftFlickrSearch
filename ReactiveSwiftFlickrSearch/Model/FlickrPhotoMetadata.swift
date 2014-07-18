//
//  FlickrPhotoMetadata.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 18/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class FlickrPhotoMetadata {
  let favourites: Int
  let comments: Int
  
  init(favourites:Int, comments: Int) {
    self.favourites = favourites
    self.comments = comments
  }
}
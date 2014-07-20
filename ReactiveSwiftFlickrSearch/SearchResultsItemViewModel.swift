//
//  SearchResultsItemViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 18/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class SearchResultsItemViewModel: NSObject {
  
  var isVisible: Bool
  let title: String
  let url: NSURL
  var favourites: NSNumber
  var comments: NSNumber
  var identifier: String
  
  let _services: ViewModelServices
  
  init(photo: FlickrPhoto, services: ViewModelServices) {
    _services = services
    title = photo.title
    url = photo.url
    identifier = photo.identifier
    isVisible = false
    favourites = -1
    comments = -1
    
    super.init()
    
    let visibleStateChanged = RACObserve(self, "isVisible").skip(1)
    
    let visibleSignal = visibleStateChanged.filter { $0.boolValue }
    let hiddenSignal = visibleStateChanged.filter { !$0.boolValue }
    
    let fetchMetadata = visibleSignal.delay(1).takeUntil(hiddenSignal)
    
    fetchMetadata.subscribeNext {
      (next: AnyObject!) -> () in
      self._services.flickrSearchService.flickrImageMetadata(self.identifier).subscribeNextAs {
        (metadata: FlickrPhotoMetadata) -> () in
        self.favourites = metadata.favourites
        self.comments = metadata.comments
      }
    }
    
  }
  
}

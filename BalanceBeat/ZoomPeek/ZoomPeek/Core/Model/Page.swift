//
//  Page.swift
//  ZoomPeek
//
//  Created by Magdalena Samuel on 1/18/24.
//

import Foundation

struct Page: Identifiable {
  let id: Int
  let imageName: String
}

    //computed property concatenate string
extension Page {
  var thumbnailName: String {
    return "thumb-" + imageName
  }
}


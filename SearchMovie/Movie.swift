//
//  Movie.swift
//  SearchMovie
//
//  Created by cscoi014 on 2019. 8. 21..
//  Copyright © 2019년 GA-Z-A. All rights reserved.
//

import UIKit

class MovieResponse: NSObject, Codable {
    var total: Int?
    var items: [Movie]?
}

class Movie: NSObject, Codable {
    var title: String?
    var link: String?
    var image: String?
    var subtitle: String?
    var pubDate: String?
    var director: String?
    var actor: String?
    var userRating: String?
}

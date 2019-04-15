//
//  CurrentWeather.swift
//  Alamofire-Weather
//
//  Created by Duc Tran on 6/11/17.
//  Copyright © 2017 Duc Tran. All rights reserved.
//

// JSON: javascript object notation

import Foundation
import UIKit


struct OmdbStruct:Decodable {
    let Search:[search]
    let totalResults:String
    let Response:String


}
struct search:Decodable {
    let Title:String
    let Year:String
    let imdbID:String
    let `Type`:String
    let Poster:String


}


class Movie:NSObject{
    var title: String?
    var year: String?
    var imdbID: String?
    var type: String?
    var poster: String?

    
}

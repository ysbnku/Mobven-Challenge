//
//  OMDBAPI.swift
//  MobvenChallenge
//
//  Created by Yavuz BİTMEZ on 15/04/2019.
//  Copyright © 2019 Yavuz BİTMEZ. All rights reserved.
//

import Foundation

protocol OMDBAPIDelegate {
    func didReceiveSearchResults(results: [Movie])
}
class OMDBAPI: NSObject {
    var delegate: OMDBAPIDelegate?
    
    
    enum OMDBAPITypes {
        case Movie
        case Series
        case Episode
        case nill
    }
  
    func getSearch(title:String,year:Int? = nil,type:OMDBAPITypes? = nil){
        let apiKey = "&apikey=6dc0afb6"
        let baseUrl = "http://www.omdbapi.com/"
        var searchQuery="?s=\(title)"
        
        if let type = type {
            switch(type) {
            case .Movie:
                searchQuery += "&type=movie"
            case .Series:
                searchQuery += "&type=series"
            case .Episode:
                searchQuery += "&type=episode"
            case .nill:
                searchQuery += ""
            }
        }
        if let year = year {
            searchQuery += "&y=\(year)"
        }
       
        let url = URL(string: baseUrl+searchQuery+apiKey)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                let resp = try JSONDecoder().decode(OmdbStruct.self, from: data!)
                let respSearch = resp.Search
                var movieResults:[Movie] = []

                for dat in respSearch{
                    let appendData = Movie()
                    appendData.imdbID = dat.imdbID
                    appendData.poster = dat.Poster
                    appendData.title = dat.Title
                    appendData.type = dat.Type
                    appendData.year = dat.Year
                    movieResults.append(appendData)
                }
                self.delegate?.didReceiveSearchResults(results: movieResults)
                
            }catch{
                print("Could not convert result to Json Dictionary")
            }
            
            }.resume()
    }
}

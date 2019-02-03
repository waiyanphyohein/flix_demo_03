//
//  IMDB.swift
//  flix_demo_03
//
//  Created by WaiYanPhyo Hein on 2/3/19.
//  Copyright © 2019 WaiYanPhyo Hein. All rights reserved.
//

import Foundation
class IMDB{
    var id: String;
    var isoID: String;
    var key: String;
    var name: String;
    var site: String;
    
    init(dictionary: [String: Any]){
        id = dictionary["id"] as? String ?? "NULL";
        isoID = dictionary["iso_3166_1"] as? String ?? "NULL"
        key = dictionary["key"] as? String ?? "NULL"
        name = dictionary["key"] as? String ?? "NULL"
        site = dictionary["site"] as? String ?? "NULL"
    }
    class func movies(dictionaries: [[String: Any]]) -> [IMDB] {
        var movies: [IMDB] = []
        for dictionary in dictionaries {
            let movie = IMDB(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}

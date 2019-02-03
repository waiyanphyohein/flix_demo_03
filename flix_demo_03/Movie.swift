//
//  Movie.swift
//  flix_demo_03
//
//  Created by WaiYanPhyo Hein on 10/4/18.
//  Copyright © 2018 WaiYanPhyo Hein. All rights reserved.
//

import Foundation
class Movie{
    var title: String = ""
    var overview: String = ""
    var releasedDate: String = ""
    var backdrop: String = ""
    var posterURL: URL?
    var posterPath: String = ""
    var movieID: Int;
    static var sharedData: [Movie] = [];

    init(dictionary: [String: Any]){
        title = dictionary["title"] as? String ?? "No Title"
        overview = dictionary["overview"] as? String ?? "NO Description"
        releasedDate = "Released Date: \(dictionary["release_date"] ?? "Released Date: N/A")"
        backdrop = dictionary["backdrop_path"] as? String ?? "No Title";
        posterPath = dictionary["poster_path"] as? String ?? "No Title";
        movieID = dictionary["id"] as? Int ?? 0000000;
    }
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        sharedData = movies;
        return movies
    }
}

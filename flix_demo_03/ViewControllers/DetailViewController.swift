//
//  DetailViewController.swift
//  flix_demo_03
//
//  Created by WaiYanPhyo Hein on 9/17/18.
//  Copyright © 2018 WaiYanPhyo Hein. All rights reserved.
//

import UIKit

enum MovieKeys{
    static let backdrop = "backdrop_path"
    static let title = "title"
    static let releaseDate = "release_date";
    static let OverView = "overview";
    static let posterPath = "https://image.tmdb.org/t/p/w500";
}

class DetailViewController: UIViewController {

    @IBOutlet weak var ReleaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var backDropPost: UIImageView!
    @IBOutlet weak var OverviewLabel: UILabel!
    
    var movie: [String: Any]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie{
            titleLabel.text = movie[MovieKeys.title] as? String;
            ReleaseDateLabel.text = movie["release_date"] as? String;
            OverviewLabel.text = movie["overview"] as? String
            let backDropURL = movie[MovieKeys.backdrop] as! String
            let smallPosterURL = movie["poster_path"] as! String
            let posterPathURL = MovieKeys.posterPath;
            let backDropURLString = URL(string: posterPathURL + backDropURL)!
            backDropPost.af_setImage(withURL: backDropURLString)
            postImageView.af_setImage(withURL: URL(string: posterPathURL + smallPosterURL)!)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

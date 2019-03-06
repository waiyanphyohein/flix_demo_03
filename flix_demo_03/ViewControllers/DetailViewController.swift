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
    
    var movie: Movie?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie{
            titleLabel.text = movie.title
            ReleaseDateLabel.text = movie.releasedDate
            OverviewLabel.text = movie.overview;
            let backDropURL = movie.backdrop;
            let smallPosterURL = movie.posterPath
            let posterPathURL = MovieKeys.posterPath;
            let backDropURLString = URL(string: posterPathURL + backDropURL)!
            backDropPost.af_setImage(withURL: backDropURLString)
            postImageView.af_setImage(withURL: URL(string: posterPathURL + smallPosterURL)!)
        }
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(self.someAction (sender:)))
        postImageView.isUserInteractionEnabled=true;
        postImageView.addGestureRecognizer(gestureRecog)
        // Do any additional setup after loading the view.
    }
    
    // Swift 3
    @objc func someAction(sender:UITapGestureRecognizer){
        
        // this is the function that lets us perform the segue
        self.performSegue(withIdentifier: "TrailerSegue", sender: self)
    }
    @IBAction func TrailerButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "TrailerSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TrailerSegue"{
            
            let trailerVC = segue.destination as! YouTubeTrailerViewController
            trailerVC.key = String((movie?.movieID)!);
            print(trailerVC.key);
            
        }
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

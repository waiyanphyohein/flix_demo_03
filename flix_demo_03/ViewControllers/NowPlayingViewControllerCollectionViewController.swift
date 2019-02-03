//
//  NowPlayingViewController.swift
//  flix_demo_03
//
//  Created by WaiYanPhyo Hein on 9/6/18.
//  Copyright © 2018 WaiYanPhyo Hein. All rights reserved.
//

import UIKit
import AlamofireImage
//import KRActivityIndicatorView

class NowPlayingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let alertController = UIAlertController(title: "Error", message: "Movie Not Found", preferredStyle: .alert);
    
    var movies:[Movie] = [];
    var refreshControl: UIRefreshControl!;
    override func viewDidLoad() {
        super.viewDidLoad();
//        let activityIndicator = KRActivityIndicatorView()
//        view.addSubview(activityIndicator)
        
        
        refreshControl = UIRefreshControl();
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 200);
        tableView.dataSource = self;
        fetchMovies();
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        // Start the activity indicator
        
        fetchMovies();
        
        // Stop the activity indicator
        // Hides automatically if "Hides When Stopped" is enabled
        
        
    }
    
    func fetchMovies(){
        self.activityIndicator.startAnimating();
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1-2")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20);
        let session = URLSession(configuration: .default, delegate: nil , delegateQueue: OperationQueue.main);
        let task = session.dataTask(with: request) { ( data, response, error) in
            
            if let error = error{
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                self.alertController.addAction(cancelAction)
               
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                self.alertController.addAction(OKAction)
                self.alertController.message = error.localizedDescription;
                self.present(self.alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                print(error.localizedDescription);
                self.refreshControl.endRefreshing();
                self.activityIndicator.stopAnimating();
            }else if let data = data{
                
                let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any];
                let moviesd = dataDictionary["results"] as! [[String:  Any]];
                print(moviesd);
                self.movies = [];
                
                for dictionary in moviesd{
                    let  movie = Movie(dictionary: dictionary)
                    self.movies.append(movie);
                 
                }
                self.tableView.reloadData();
                self.refreshControl.endRefreshing();
                self.activityIndicator.stopAnimating();
                              
            }
            
            
        }
        
        task.resume();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell;
        if let index_path = tableView.indexPath(for: cell){
            let movie = movies[index_path.row]
            let detailViewController =  segue.destination as! DetailViewController
            print(movie)
            detailViewController.movie = movie;
        }
    }
    func tableView(_ tableView: UITableView , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell;
        
        let movie = movies[indexPath.row];
        
        let title = movie.title
        let overview = movie.overview
        let posterPathString = movie.posterPath
        let baseURLString = "https://image.tmdb.org/t/p/w500";
        
        cell.titleLabel.text = title;
        cell.overviewLabel.text = overview;
        if posterPathString != ""{
            let posterURL = URL(string: baseURLString + posterPathString)!;
            cell.posterImageView.af_setImage(withURL: posterURL);
        }
        return cell;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

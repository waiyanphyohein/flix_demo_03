//
//  GridViewController.swift
//  flix_demo_03
//
//  Created by WaiYanPhyo Hein on 9/19/18.
//  Copyright © 2018 WaiYanPhyo Hein. All rights reserved.
//

import UIKit

class GridViewController: UIViewController,UICollectionViewDataSource {
    
    private var movies: [Movie] = Movie.sharedData;
    let alertController = UIAlertController(title: "Error", message: "Movie Not Found", preferredStyle: .alert);
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item];
        let posterPathString = movie.posterPath
        let baseURLString = "https://image.tmdb.org/t/p/w500";
        
        if posterPathString != ""{
            let posterURL = URL(string: baseURLString + posterPathString)!;
            cell.posterImageView.af_setImage(withURL: posterURL);
        }
        
        return cell;
    }
    private func fetchMovies(){
        //self.activityIndicator.startAnimating();
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1-2")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20);
        let session = URLSession(configuration: .default, delegate: nil , delegateQueue: OperationQueue.main);
        let task = session.dataTask(with: request) { ( data, response, error) in
            
            if let error = error{
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//                    // handle cancel response here. Doing nothing will dismiss the view.
//                }
//                // add the cancel action to the alertController
//                //self.alertController.addAction(cancelAction)
//
//                // create an OK action
//                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
//                    // handle response here.
//                }
                // add the OK action to the alert controller
                //self.tabBarController.addAction(OKAction)
                //self.tabBarController.message = error.localizedDescription;
                //self.present(self.tabBarControllertabBarController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                //}r
                print(error.localizedDescription);
                //self.refreshControl.endRefreshing();
                //self.activityIndicator.stopAnimating();
            }else if let data = data{
                
                let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any];
                let moviesd = dataDictionary["results"] as! [[String:  Any]];
                print(moviesd);
                self.movies = [];
                
                for dictionary in moviesd{
                    let  movie = Movie(dictionary: dictionary)
                    self.movies.append(movie);
                }
                
                self.collectionView.reloadData();
                //self.refreshControl.endRefreshing();
                //self.activityIndicator.stopAnimating();
                
            }
            
            
        }
        
        task.resume();
    }

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.movies.count == 0{
            fetchMovies();
        }

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = layout.minimumInteritemSpacing;        
        let cellsPerLine: CGFloat = 2;
//        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1) ;
        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2) / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        collectionView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell;
        if let index_path = collectionView.indexPath(for: cell){
            let movie = movies[index_path.row]
            
            let detailViewController =  segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

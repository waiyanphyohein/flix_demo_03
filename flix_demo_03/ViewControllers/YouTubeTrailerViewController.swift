//
//  YouTubeTrailerViewController.swift
//  flix_demo_03
//
//  Created by WaiYanPhyo Hein on 2/2/19.
//  Copyright © 2019 WaiYanPhyo Hein. All rights reserved.
//

import UIKit
import WebKit

class YouTubeTrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var youTubeWebView: WKWebView!
    var videoID: String = "https://www.youtube.com";
    var key: String = "95ghQs5AmNk";
    var imdbs: [IMDB] = [];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchMovieID();
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            
            print(self.key);
            self.videoID = "https://www.youtube.com/watch?v=\(self.key)";
            
            let urlNet = URL(string: self.videoID);
            
            let requestLink = URLRequest(url: urlNet ?? URL(string: "https://www.youtube.com")!);
            self.youTubeWebView.load(requestLink);
            
            // Put your code which should be executed with a delay here
        })
        
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func fetchMovieID(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(key)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20);
        let session = URLSession(configuration: .default, delegate: nil , delegateQueue: OperationQueue.main);
        let task = session.dataTask(with: request) { ( data, response, error) in
            
            if let error = error{
                
                print(error.localizedDescription);
            }else if let data = data{
                
                
                let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any];
                
                let moviesd = dataDictionary["results"] as! [[String: Any]];
                
                for dictionary in moviesd{
                    let imdb = IMDB(dictionary: dictionary)
                    
                    self.key = imdb.key;
                }
                
            }
            
            
        }
        task.resume()
        
        
     
    }
    
}
extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Nhan Nguyen on 12/2/21.
//  Copyright © 2021 Nhan Nguyen. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    var movieVideos = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)
        
        let movieId = String(movie["id"] as! Int)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/" + movieId + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                    self.movieVideos = dataDictionary["results"] as! [[String:Any]]
             }
        }
        task.resume()
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination
        // Pass the selected object to the new view controller
                
        // Find the selected movie
        let trailerUrlKey = movieVideos[0]["key"] as! String
        let trailerUrl = "https://www.youtube.com/watch?v=" + trailerUrlKey
        
        // Pass the selected movie to the details view controller
        let webkitViewController = segue.destination as! WebkitViewController // need to explicitly cast into MovieDetailsViewController to have access to the 'movie' property in it

        webkitViewController.trailerUrl = trailerUrl
    }

}

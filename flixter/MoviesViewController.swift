//
//  MoviesViewController.swift
//  flixter
//
//  Created by Ali Malik on 2/20/21.
//

import UIKit
//Step 1, add UITableViewDataSource, UITableViewDelegate
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Step 2, have these 2 functions [see below]


    //Properties
    // Avalible for the lifetime of this screen
    
    //Array of Dictionaryes
    var movies  = [[String:Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Step 3
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    
        print("HELLO")
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                //print(dataDictionary)
                //movies is set to the "results" key value
                //Casting
                self.movies = dataDictionary["results"] as! [[String:Any]]
                // calls the functions below once more
                self.tableView.reloadData()
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    //Step 2
    //These fucntions are not called continuosly
    // called when view loader is spun up
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of rows
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Returns cell
        let cell = UITableViewCell()
        
        // movies[index]
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        
        // \() is throwing in a variable
        //cell.textLabel!.text = "row: \(indexPath.row)"
        cell.textLabel!.text = title
        //why ? or !
        // Swift
        return cell
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

//
//  SearchViewController.swift
//  FlickrSearch
//
//  Created by Charles Schneiders on 4/25/17.
//  Copyright © 2017 Charles Schneiders. All rights reserved.
//

import UIKit
import Foundation


struct flickrResults {

    var title: String?
    var media: String?

}

class SearchViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResults: UITableView!
    
    var results: [flickrResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let demoURL = "https://api.flickr.com/services/feeds/photos_public.gne?tags=test&;tagmode=any&format=json&jsoncallback=1"
        getFromFlickrApi(flckrURL: demoURL)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Trying to create demo taking from sample printed url string
    func createapidata() -> [flickrResults] {
        
        var flickrResult = flickrResults()
        flickrResult.title = "IMGP3701jpg"
        flickrResult.media = ""
        results.append(flickrResult)
        
        
        return results
        
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text!
        
        let flickerURL = "https://api.flickr.com/services/feeds/photos_public.gne?tags=\(searchText)&;tagmode=any&format=json&jsoncallback=1"
        
        getFromFlickrApi(flckrURL: flickerURL)
        searchBar.resignFirstResponder()
    }
    
    func getFromFlickrApi(flckrURL: String){
        
        let url = URL(string: flckrURL)
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            let results = JSON(data: data!)
            
            var resultDictionary: NSDictionary?
            
            do {
                resultDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                print(result)
            } catch {
                print(error)
            }
            
            print(resultDictionary)
            
            print(results)
        
        }
        
        
        task.resume()
    }
    
    
    //Tableview Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlickrFeedCell", for: indexPath) as! FlickrFeedTableViewCell
        
        let feed = self.results[indexPath.row] as flickrResults
        
        cell.nameLabel?.text = feed.title
        
        
        let url = URL(string: feed.media!)
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: url!)
        
        //cell.mediaImageView?.setImageWithURL(NSURL(string: feed.media)!)
        
        return cell
    }
    
    //Prepare for segue to detail screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send contents to view
        if segue.identifier == "segueToDetailView" {
            if let detailVC = segue.destination as? DetailVC {
                //Set variables in detail VC
                
            }
        }
    }


}


class FlickrFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel :UILabel?
    @IBOutlet weak var mediaImageView :UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
}




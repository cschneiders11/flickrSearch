//
//  DetailVC.swift
//  FlickrSearch
//
//  Created by Charles Schneiders on 4/25/17.
//  Copyright © 2017 Charles Schneiders. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var flickrImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descript: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

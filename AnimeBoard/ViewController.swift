//
//  ViewController.swift
//  AnimeBoard
//
//  Created by Jonathan Green on 12/21/14.
//  Copyright (c) 2014 Jonathan Green. All rights reserved.
//

import UIKit
var anime:String = "bleach"

var ran = Int(arc4random_uniform(20000)+1)

class CustomeTableViewCell: UITableViewCell{

    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
}

class ViewController: UIViewController{
    ///Image
    @IBOutlet var imageTableView: UITableView!
    
    @IBOutlet weak var Banner: UIImageView!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var smallImage: UIImageView!
    
    //@IBOutlet weak var animeImage: UIImageView!
    ///Views
    
    ///Labels
    @IBOutlet weak var UserName: UILabel!

    @IBOutlet weak var userInfo: UILabel!
    
    @IBOutlet weak var ActivityInfo: UILabel!
    
    @IBOutlet weak var timeFrame: UILabel!
    
    @IBOutlet weak var animeDays: UILabel!
    
    @IBOutlet weak var mangaChp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //userAuth(Banner,mainImage,smallImage,UserName,userInfo,ActivityInfo,timeFrame,animeDays,mangaChp)
        apiAuth(mainImage,Banner,ran)
        //searchAuth()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


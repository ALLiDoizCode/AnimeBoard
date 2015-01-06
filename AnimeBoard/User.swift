//
//  User.swift
//  AnimeBoard
//
//  Created by Jonathan Green on 12/25/14.
//  Copyright (c) 2014 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftHTTP

///Authincation
func userAuth(Banner:UIImageView,mainImage:UIImageView,smallImage:UIImageView,UserName:UILabel,userInfo:UILabel,ActivityInfo:UILabel,timeFrame:UILabel,animeDays:UILabel,mangaChp:UILabel){
    var request = HTTPTask()
    //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
    let params: Dictionary<String,AnyObject> = ["grant_type": "client_credentials", "client_id":"di3twater-1nxqk", "client_secret": "f9S24EMx8mgcPTsZcWKBdT"]
    request.POST("https://anilist.co/api/auth/access_token", parameters: params, success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            let json = JSON(data:data)
            let accessToken:String = json["access_token"].stringValue!
            println(accessToken)
            Favorite(accessToken)
            userGet(accessToken,Banner,mainImage,smallImage,UserName,userInfo,ActivityInfo,timeFrame,animeDays,mangaChp)
        }
        
        },failure: {(error: NSError, response: HTTPResponse?) in
            
    })
}

///User Get
func userGet(Token:String,Banner:UIImageView,mainImage:UIImageView,smallImage:UIImageView,UserName:UILabel,userInfo:UILabel,ActivityInfo:UILabel,timeFrame:UILabel,animeDays:UILabel,mangaChp:UILabel){
    var request = HTTPTask()
    request.GET("https://anilist.co/api/user/Josh", parameters: ["access_token":"\(Token)","page": "1"], success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            var json = JSON(data:data)
            ///images
            var imageBig = json["image_url_lge"].stringValue
            var imageSmall = json["image_url_med"].stringValue
            var imageBanner = json["image_url_banner"].stringValue
            //labels
            var name = json["display_name"].stringValue
            var userAbout = json["about"].stringValue
            var days = json["anime_time"].stringValue
            var chapter = json["manga_chap"].stringValue
            //Adding Labels
            UserName.text = name
            userInfo.text = userAbout
            animeDays.text = days
            mangaChp.text = chapter
            //Adding Images
            var bgBig = UIImage(data: NSData(contentsOfURL: NSURL(string:imageBig!)!)!)
            mainImage.image = bgBig
            var bgSmall = UIImage(data: NSData(contentsOfURL: NSURL(string:imageSmall!)!)!)
           smallImage.image = bgBig
            var bgBanner = UIImage(data: NSData(contentsOfURL: NSURL(string:imageBanner!)!)!)
            Banner.image = bgBanner
            
        }
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("error: \(error)")
    })
}

///Get Search Results
func Favorite(Token:String){
    var request = HTTPTask()
    request.GET("https://anilist.co/api/user/Josh/favourites", parameters: ["access_token":"\(Token)"], success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            //let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("response: \(str)") //prints the HTML of the page
            var json = JSON(data:data)
            
            var animeValue = json["anime"].arrayValue
            var animeCount = animeValue?.count
            println("\(animeValue?.count)")
            for var i = 0; i < animeCount; i++ {
                    var favImage = UIImageView()
                    var imageData = json["anime"][i]["image_url_med"].stringValue
                    favImage.frame = CGRect(x: 30, y: 100, width: 61, height: 96)
                    var bgFav = UIImage(data: NSData(contentsOfURL: NSURL(string:imageData!)!)!)
                    println(imageData)
                    favImage.image = bgFav
            
            }
            
        }
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("error: \(error)")
    })
}



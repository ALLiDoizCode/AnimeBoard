//
//  GetAnime.swift
//  AnimeBoard
//
//  Created by Jonathan Green on 12/22/14.
//  Copyright (c) 2014 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftHTTP

///Authincation
func apiAuth(Image:UIImageView,bannerInfo:UIImageView,num:Int){
    var request = HTTPTask()
    //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
    let params: Dictionary<String,AnyObject> = ["grant_type": "client_credentials", "client_id":"di3twater-1nxqk", "client_secret": "f9S24EMx8mgcPTsZcWKBdT"]
    request.POST("https://anilist.co/api/auth/access_token", parameters: params, success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            let json = JSON(data:data)
            let accessToken = json["access_token"].stringValue
            //println(accessToken)
            //println(num)
            apiGet(accessToken!,Image,bannerInfo,num)
        }
        
        },failure: {(error: NSError, response: HTTPResponse?) in
            
    })
}
//////Get anime/////
func apiGet(Token:String,Image:UIImageView,bannerInfo:UIImageView,num:Int){
    var somenum = num
    var filter:String? = "Comedy"
    var filterSum:Int = 0
    var f = 0
    var request = HTTPTask()
    request.GET("https://anilist.co/api/anime/\(somenum)", parameters: ["access_token":"\(Token)"] , success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            let json = JSON(data:data)
            var gArray = json["genres"].arrayValue
            var imageInfo:String? = json["image_url_lge"].stringValue
            var bannerdata:String? = json["image_url_banner"].stringValue
            var youtube:String? = json["youtube_id"].stringValue
            var gArray2 = gArray?.count
            for var i = 0; i < gArray2; i++ {
                var compare = json["genres"][i].stringValue
                println(compare)
                if compare == filter {
                    f = 1;
                    println(f)
                        if f == 1 || filter == nil{
                            println(imageInfo)
                            println("banner \(bannerdata)")
                            println("trailer \(youtube)")
                            ////imageLoop////
                            if imageInfo != nil && compare != "Hentai"{
                                var bgImage = UIImage(data: NSData(contentsOfURL: NSURL(string:imageInfo!)!)!)
                                Image.image = bgImage
                                //banner
                                /*var bnImage = UIImage(data: NSData(contentsOfURL: NSURL(string:bannerdata!)!)!)
                                bannerInfo.image = bnImage*/

                            }else{
                                println("image is nil")
                                var ran = Int(arc4random_uniform(9000)+1)
                                apiGet(Token,Image,bannerInfo,ran)
                            }
                            ////imageLoop////
                        }
                    }

            }
            if f != 1 {
                println("filter does not match")
                var ran = Int(arc4random_uniform(9000)+1)
                apiGet(Token,Image,bannerInfo,ran)

            }

            }
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("error: \(error)")
    })
    
}
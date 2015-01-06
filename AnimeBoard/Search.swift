//
//  Search.swift
//  AnimeBoard
//
//  Created by Jonathan Green on 12/22/14.
//  Copyright (c) 2014 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftHTTP

///Authincation
func searchAuth(){
    var request = HTTPTask()
    //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
    let params: Dictionary<String,AnyObject> = ["grant_type": "client_credentials", "client_id":"di3twater-1nxqk", "client_secret": "f9S24EMx8mgcPTsZcWKBdT"]
    request.POST("https://anilist.co/api/auth/access_token", parameters: params, success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            let json = JSON(data:data)
            let accessToken:String = json["access_token"].stringValue!
            println(accessToken)
            apiSearch(accessToken)
        }
        
        },failure: {(error: NSError, response: HTTPResponse?) in
            
    })
}


///Get Search Results
func apiSearch(Token:String){
    var request = HTTPTask()
    request.GET("https://anilist.co/api/anime/search/Attack", parameters: ["access_token":"\(Token)"], success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("response: \(str)") //prints the HTML of the page
        }
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("error: \(error)")
    })
}


// Class: urlInfo to be seen through all Classes
/*class AuthInfo {
    // Class function: Return URL request so we only need to define it once in code
    class func getAuth() -> NSURLRequest {
        var url: NSURL? = NSURL(string: "https://anilist.co/api/auth/access_token")
        var urlRequest: NSURLRequest? = NSURLRequest(URL: url!)
        
        return urlRequest!
    }
}*/

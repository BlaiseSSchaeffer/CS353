//
//  ColorClient.swift
//  ColorBoxThing
//
//  Created by Blaise Schaeffer on 3/29/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import Foundation

class ColorClient {
    static let sharedClient = ColorClient()
    
    func getColors(completion: ([ColorBox]) -> ()) {
        var colors: [ColorBox] = []
        
        get(clientURLRequest("videosrc/colors.json")) { (success, object) in
            if let object = object as? [String: AnyObject],
               let results = object["results"] as? [[String: AnyObject]] {
                for result in results {
                    if let color = ColorBox(json: result) {
                        colors.append(color)
                    }
                }
            }
            completion(colors)
        }
    }
    
    private func get(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }
    
    private func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://thatthinginswift.com/"+path)!)
        
        return request
    }
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: (success: Bool, object: AnyObject?) -> ()) {
        request.HTTPMethod = method
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
                let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
                    completion(success: true, object: json)
                } else {
                    completion(success: false, object: json)
                }
            }
        }.resume()
    }
}
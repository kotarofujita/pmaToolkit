//
//  pmaCacheManager.swift
//  Pods
//
//  Created by Peter.Alt on 2/25/16.
//  Copyright © 2016 Philadelphia Museum of Art. All rights reserved.
//

import Foundation
import SwiftyJSON

open class pmaCacheManager {
    
    open static func loadJSONFile(_ endpoint: String) -> JSON? {
        if let data = self.getData(self.constructURLForEndpoint(endpoint), ignoreCache: true) {
            let jsonData = JSON(data: data)
            
            if jsonData != JSON.null {
                return jsonData
            } else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    // MARK: Private
    
    fileprivate static func makeURLRequest(_ url: URL, ignoreCache: Bool = false) -> URLRequest {
        var cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
        if ignoreCache {
            cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        }
        let request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: pmaToolkit.settings.cacheSettings.requestTimeout)
        
        return request
    }
    

    fileprivate static func constructURLForEndpoint(_ endpoint : String) -> URL {
        return URL(string: pmaToolkit.settings.cacheSettings.hostProtocol + pmaToolkit.settings.cacheSettings.hostName + "/" + (endpoint as String))!
    }
    
    fileprivate static func getData(_ url: URL, ignoreCache: Bool = false) -> Data? {
        

        let request = self.makeURLRequest(url, ignoreCache: ignoreCache)
        var data: Data?
        do {
            data = try NSURLConnection.sendSynchronousRequest(request, returning: nil)
        } catch _ as NSError {
            data = nil
        }
        
        if data != nil {
            return data
        } else {
            return nil
        }
    }
    
}

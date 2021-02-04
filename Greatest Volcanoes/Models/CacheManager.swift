//
//  CasheManager.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 25.01.2021.
//  Copyright © 2020 Daniil Marusenko. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var cache = [String : Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        
        cache[url] = data
        
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        
        return cache[url]
        
    }
    
}

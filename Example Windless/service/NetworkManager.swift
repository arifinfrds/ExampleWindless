//
//  DataManager.swift
//  Example Windless
//
//  Created by Arifin Firdaus on 6/26/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    fileprivate let defaultUrl = "https://jsonplaceholder.typicode.com/photos/"
    
    func requestPhoto(forId id: Int, completion: @escaping (Photo?, Error?) -> ()) {
        let url = "\(defaultUrl)\(id)"
        Alamofire.request(url).responsePhoto { response in
            if let photo = response.result.value {
                completion(photo, nil)
                return
            }
            completion(nil, response.error)
        }
    }
    
}

//
//  Networking.swift
//  fb-info
//
//  Created by Mason Macias on 9/3/17.
//  Copyright © 2017 griffinmacias. All rights reserved.
//

import Foundation
import FacebookCore

final class APIClient {
    static let shared = APIClient()
    fileprivate init() {} //Prevents others from using the default () init
    
    public func downloadData(with url: URL, completion: @escaping (_ data: Data?, _ error: Error?)-> Void) {
        let session = URLSession(configuration: .default)
        let downloadDataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else {
                guard let _ = response as? HTTPURLResponse else {
                    print("couldn't get response code for some reason")
                    completion(nil, nil)
                    return
                }
                guard let data = data else {
                    print("couldn't get image: image is nil")
                    completion(nil, nil)
                    return
                }
                completion(data, nil)
            }
        }
        downloadDataTask.resume()
    }
    
    public func getFacebookInfo(completion: @escaping (_ dictionary: [String: Any]?, _ error: Error?) -> Void) {
        let request = GraphRequest(graphPath: "me",
                                   parameters: [ "fields": "first_name, last_name, picture.type(large), email" ])
        request.start { (response, result) in
            switch result {
            case .failed(let error):
                print(error)
                completion(nil, error)
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    print(responseDictionary)
                    completion(responseDictionary, nil)
                }
            }
        }
    }
}

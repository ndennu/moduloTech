//
//  DataFetcher.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 28/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation
import UIKit

class DataFetcher {
    
    enum Result {
        case Success(User, [Equipment])
        case Error(String, String?)
    }
    
    static let shared = DataFetcher()
    
    private init() {
        
    }
    
    func fetch(completion: @escaping(Result) -> Void) {
        // IMPORTANT !!
        // change the url from http to https
        // and remove the hack in the info plist named "App Transport Security Settings"
        let urlToFetch = "http://storage42.com/modulotest/data.json"
        
        guard let url = URL(string: urlToFetch) else {
            completion(.Error("Url no conform", nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        _ = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data else {
                completion(.Error("Web Service Error", nil))
                return
            }
            
            DispatchQueue.main.async {
                
                let decoder = JSONDecoder()
                let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = coreDataContext
                
                do {
                    let res = try decoder.decode(DataResult.self, from: data)
                    
                    guard
                        let devices = res.devices,
                        let user = res.user
                        else {
                            completion(.Error("Error parsing data", nil))
                            return
                    }
                    
                    completion(.Success(user, devices))
                    
                } catch let error {
                    completion(.Error("Error: data decode", error.localizedDescription))
                }
                
            }
        }).resume()
    }
}

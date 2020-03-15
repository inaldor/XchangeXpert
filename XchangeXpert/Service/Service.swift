//
//  Service.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 15/03/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import Foundation

/// The service being responsible for fetching data from the API
class Service: NSObject {
    
    // MARK: Properties

    static let shared = Service()
    
    // MARK: Imperatives
    
    /// Function to fetch items from the API
    func fetchItems(completion: @escaping (Item?, APIError?) -> ()) {
        
        /// Building the URL for fetching
        let urlString = "\(APIConstants.baseURL)contentList.json"
        guard let url = URL(string: urlString) else { return }
        
        /// Calling the URL Session with the given URL
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            /// Checking for errors
            if let err = err {
                completion(nil, APIError.requestFailed)
                print("Failed to fetch items:", err)
                return
            }
            
            /// Checking the response
            guard let data = data else { return }
            do {
                
                /// Trying to decode the response
                let items = try JSONDecoder().decode(Item.self, from: data)
                DispatchQueue.main.async {
                    completion(items, nil)
                }
            } catch {
                print("Failed to decode:", APIError.parsingFailed)
            }
            }.resume()
    }
    
    /// Function to fetch the details from a given item
    func fetchItemDetails(item: String, completion: @escaping (ItemDetail?, APIError?) -> ()) {
        
        /// Building the URL for fetching
        let urlString = "\(APIConstants.baseURL)content/\(item).json"
        guard let url = URL(string: urlString) else { return }
        
        /// Calling the URL Session with the given URL
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            /// Checking for errors
            if let err = err {
                completion(nil, APIError.requestFailed)
                print("Failed to fetch items:", err)
                return
            }
            
            /// Checking the response
            guard let data = data else { return }
            do {
                
                /// Trying to decode the response
                let itemDetail = try JSONDecoder().decode(ItemDetail.self, from: data)
                DispatchQueue.main.async {
                    completion(itemDetail, nil)
                }
            } catch {
                print("Failed to decode:", APIError.parsingFailed)
            }
            }.resume()
    }
}

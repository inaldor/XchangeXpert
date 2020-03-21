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
    //var auxString: String = nil
    var auxString = String()
    
    // MARK: Imperatives
    
    /// Function to fetch items from the API
    func fetchItems(currencyPairs: [String], completion: @escaping ([String:Double]?, APIError?) -> ()) {
        
        for pair in currencyPairs {
            
            if auxString.isEmpty {
                auxString = "pairs=" + pair
            } else {
                auxString = auxString + "&pairs=" + pair
            }
        }
        
        /// Building the URL for fetching
        let urlString = "\(APIConstants.baseURL)" + "\(auxString)"
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
                
                 //guard let exchangeData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                        let conversionRates = exchangeData[kRates] as? [String: Double],
//                        let conversionRate = conversionRates[outputCurrency] else {
//                        completion { throw CoinConverterBusinessError.parseError }
//                        return
//                    }
                
                
                /// Trying to decode the response
                //let items = try JSONDecoder().decode(Item.self, from: data)
                
                let exchangeData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String : Double]
                if let object = exchangeData as? [String:Double] {
                    DispatchQueue.main.async {
                        completion(exchangeData, nil)
                    }
                }
            } catch {
                print("Failed to decode:", APIError.parsingFailed)
            }
            }.resume()
    }
}

//let json = try JSONSerialization.jsonObject(with: data, options: [])
//if let object = json as? [String: Any] {
//    // json is a dictionary
//    print(object)

//private func handleSuccess(outputCurrency: String, data: Data, completion: @escaping CoinConverterCallback) {
//    guard let exchangeData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//        let conversionRates = exchangeData[kRates] as? [String: Double],
//        let conversionRate = conversionRates[outputCurrency] else {
//        completion { throw CoinConverterBusinessError.parseError }
//        return
//    }
//
//    completion { conversionRate }
//}


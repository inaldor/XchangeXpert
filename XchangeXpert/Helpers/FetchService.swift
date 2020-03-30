////
////  FetchService.swift
////  XchangeXpert
////
////  Created by Inaldo Ramos Ribeiro on 28/03/2020.
////  Copyright © 2020 Inaldo's Software Development. All rights reserved.
////
//
//import UIKit
//
//class FetchService {
//
//    weak var delegate: DataModelDelegate?
//
//    func fetching(withSuccessHandler handler: @escaping (Any?) -> Any?) {
//        
//        //rates = [:]
//        let userDefaults = UserDefaults.standard
//        let value = userDefaults.stringArray(forKey: "currencies_selected") ?? []
//        print(value)
//
//        //let array = ["GBPUSD","GBPBRL","EURUSD","USDBRL"]
//
//        /// Call for the Service to fetch the items from the API
//        Service.shared.fetchItems(currencyPairs: value) { (items, error) in
//
//                /// Checking for errors after try to fetching the items
//                if let error = error {
//                   print("Failed to fetch items:", error)
//                   return
//                }
//
//                if let items = items {
//
//                    print(items)
//
//                    let sorted = items.sorted { value.firstIndex(of: $0.key)! < value.firstIndex(of: $1.key)! }
//
//
//
//                }
//
//        }
//
//    }
//
//}

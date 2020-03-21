//
//  UserDefaults.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 20/03/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    // MARK: Constants
    
    /// The keys used to manage the values in the user defaults.
    enum Keys {
        static let currenciesSelected = "currencies_selected"
    }
}

extension UserDefaults {
    
    // MARK: Properties
    
    /// Key storing the currencies to be calculated
//    static var currenciesSelected: [String]? {
//        get {
//            return UserDefaults.standard.stringArray(forKey: Keys.currenciesSelected)
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Keys.currenciesSelected)
//        }
//    }
    
//    var intArray: [String] {
//        get {
//            return UserDefaults.standard.array(forKey: "intArray") as? [String] ?? []
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "intArray")
//        }
//    }
    
//    let usD = UserDefaults.standard
//    var urls = usD.stringArray(forKey: "WeatherArray") ?? []
//
//    //MARK: Save Array of Currencies
//    func setCurrencies(value: [String]){
//        set(value, forKey: Keys.currenciesSelected)
//    }
//
//    //MARK: Retrieve array of Currencies
//    func getCurrencies() -> [String]{
//        return stringArray(forKey: Keys.currenciesSelected) ?? []
//    }
}

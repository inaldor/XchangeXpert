//
//  UserDefaults.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 17/04/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    // MARK: Constants
    
    /// The keys used to manage the values in the user defaults.
    enum Keys {
        static let currencies = "saved_currencies"
    }
    
    static var selectedCurrencies: Array<String> {
        get {
            return UserDefaults.standard.stringArray(forKey: Keys.currencies) ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currencies)
        }
    }
}


 // let savedPairs = userDefaults.stringArray(forKey: "currencies_selected") ?? []

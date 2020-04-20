//
//  ManageCurrencies.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 17/04/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class ManageCurrencies: Management {
    
    //let savedPairs = UserDefaults.selectedCurrencies
    private var savedCurrencyDescriptions: [String] = []

    func extractSavedCurrencies() -> [String] {
        
        let savedPairs = UserDefaults.selectedCurrencies
        
        print(savedPairs)

        let savedPairCurrencies = stride(from: 0, to: savedPairs.count, by: 2).map { savedPairs[$0] }
        let savedPairCurrenciesEven = stride(from: 1, to: savedPairs.count, by: 2).map { savedPairs[$0] }
        savedCurrencyDescriptions = extractArrayElement(entireString: savedPairCurrenciesEven)

        print(savedPairCurrencies)
        
        return savedPairCurrencies
        
    }
    
    func extractCurrencyBaseDesc() -> [String] {

        let currencyBaseDesc = stride(from: 0, to: savedCurrencyDescriptions.count, by: 2).map { savedCurrencyDescriptions[$0] }

        print(currencyBaseDesc)
        
        return currencyBaseDesc


    }
    
    func extractCurrencyQuoteDesc() -> [String] {
        
        let currencyQuoteDesc = stride(from: 1, to: savedCurrencyDescriptions.count, by: 2).map { savedCurrencyDescriptions[$0] }

        print(currencyQuoteDesc)
        
        return currencyQuoteDesc

    }
    
    func extractArrayElement(entireString: [String]) -> [String] {
        
        var arrayElements: [String] = []
        
        for r in entireString {
            
            let element = r.split(separator: "/")
            
            for x in 0..<element.count {
                arrayElements.append(String(element[x]))
            }
        }
        
        print(arrayElements)
        return arrayElements
    }
    
    func removeArrayElement(position: Int) -> [String] {
        
        var savedPairs = UserDefaults.selectedCurrencies
        
        if position != 0 {
            
            savedPairs.remove(at: (position*2)+1)
            savedPairs.remove(at: (position*2))
            
        } else {
            
            savedPairs.remove(at: 0)
            savedPairs.remove(at: 0)
        }
        
        print(savedPairs)
        return savedPairs
    }
    
    func formatRate(rate: Double) -> NSAttributedString {

        let rateWithoutFormat = NSNumber(value: rate)
        
        //print(rateWithoutFormat)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 4
        let rateFormatted = numberFormatter.string(from: rateWithoutFormat)
        
        let rateWithoutComma = rateFormatted?.replacingOccurrences(of: ".", with: ",")
        
        let rateWithoutLastDigs = String(rateWithoutComma?.dropLast(2) ?? "X,XX")
        
        let rateLastDigs = String(rateWithoutComma?.suffix(2) ?? "XX")
        
        
        let secondAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        let thirdAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]

        let firstString = NSMutableAttributedString()
        let secondString = NSAttributedString(string: rateWithoutLastDigs, attributes: secondAttributes)
        let thirdString = NSAttributedString(string: rateLastDigs, attributes: thirdAttributes)

        firstString.append(secondString)
        firstString.append(thirdString)
        
        return(firstString)
        
    }
}

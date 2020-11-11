//
//  CurrenciesTableViewController.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 29/02/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class CurrenciesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    private var currencies: [String] = []
    private var selectedCurrencies: [String] = []
 
    //let userDefaults = UserDefaults.standard
    
    private var udArray = UserDefaults.selectedCurrencies
        
    private let currencyData = [CurrencyDetails(nameDescription: "Pound Sterling", isoCode: "GBP"), CurrencyDetails(nameDescription: "Euro", isoCode: "EUR"), CurrencyDetails(nameDescription: "United States Dollar", isoCode: "USD"), CurrencyDetails(nameDescription: "Australian Dollar", isoCode: "AUD"), CurrencyDetails(nameDescription: "Bulgarian Lev", isoCode: "BGN"), CurrencyDetails(nameDescription: "Brazilian Real", isoCode: "BRL"), CurrencyDetails(nameDescription: "Canadian Dollar", isoCode: "CAD"), CurrencyDetails(nameDescription: "Swiss Franc", isoCode: "CHF"), CurrencyDetails(nameDescription: "Renminbi", isoCode: "CNY"), CurrencyDetails(nameDescription: "Czech Koruna", isoCode: "CZK"), CurrencyDetails(nameDescription: "Danish Krone", isoCode: "DKK"), CurrencyDetails(nameDescription: "Hong Kong Dollar", isoCode: "HKD"), CurrencyDetails(nameDescription: "Croatian Kuna", isoCode: "HRK"), CurrencyDetails(nameDescription: "Hungarian Forint", isoCode: "HUF"), CurrencyDetails(nameDescription: "Indonesian Rupiah", isoCode: "IDR"), CurrencyDetails(nameDescription: "Israeli New Shekel", isoCode: "ILS"), CurrencyDetails(nameDescription: "Indian Rupee", isoCode: "INR"), CurrencyDetails(nameDescription: "Icelandic Króna", isoCode: "ISK"), CurrencyDetails(nameDescription: "Japanese Yen", isoCode: "JPY"), CurrencyDetails(nameDescription: "South Korean Won", isoCode: "KRW"), CurrencyDetails(nameDescription: "Mexican Peso", isoCode: "MXN"), CurrencyDetails(nameDescription: "Malaysian Ringgit", isoCode: "MYR"), CurrencyDetails(nameDescription: "Norwegian Krone", isoCode: "NOK"), CurrencyDetails(nameDescription: "New Zealand Dollar", isoCode: "NZD"), CurrencyDetails(nameDescription: "Philippine Peso", isoCode: "PHP"), CurrencyDetails(nameDescription: "Polish Złoty", isoCode: "PLN"), CurrencyDetails(nameDescription: "Romanian Leu", isoCode: "RON"), CurrencyDetails(nameDescription: "Russian Ruble", isoCode: "RUB"), CurrencyDetails(nameDescription: "Swedish Krona", isoCode: "SEK"), CurrencyDetails(nameDescription: "Singapore Dollar", isoCode: "SGD"), CurrencyDetails(nameDescription: "Thai Baht", isoCode: "THB"), CurrencyDetails(nameDescription: "South African Rand", isoCode: "ZAR")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchListCurrencies()
        
        //print(udArray)
        
        //print(UserDefaults.selectedCurrencies)
        
        //UserDefaults.selectedCurrencies = ["i","ok"]
        
        //print(UserDefaults.selectedCurrencies)
            
        
    }
    
    private func fetchListCurrencies() {
        
        do {
            let jsonURL = Bundle.main.url(forResource: "currencies", withExtension: "json")
            let jsonDecoder = JSONDecoder()
            let jsonData = try Data(contentsOf: jsonURL!)
            var jsonSentence = try jsonDecoder.decode([String].self, from: jsonData)
            
            for (indexData, listOrdered) in currencyData.enumerated() {
                
                for (indexJson, elementJson) in jsonSentence.enumerated() {
                    
                    if listOrdered.isoCode == elementJson {
                        
                        print("equal")
                        jsonSentence.remove(at: indexJson)
                        jsonSentence.insert(listOrdered.isoCode, at: indexData)
                                                                
                    }
                    
                }
            }

            currencies = jsonSentence

        } catch {
           print(error)
        }
        
    }
    
    private func findDescription(isoCode: String) -> String? {
        
        for element in currencyData {
            
            if element.isoCode == isoCode {
                
                print("equal")
                                
                return element.nameDescription
                
            }
            
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CurrenciesTableViewCell
        
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true

        cell.currencyName.text = currencies[indexPath.row]
        //cell.currencyName.alpha = 0.5
        
        for element in currencyData {
            
            if element.isoCode == currencies[indexPath.row] {
                
                cell.currencyNameDescriptionLabel.text = element.nameDescription
                cell.currencyImageView.image = UIImage(named: "\(element.nameDescription)")

            }
        }
        
        //udArray.insert(currenciesCombined, at: 0)
        //udArray.insert(descriptionCombined, at: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let currencyName = currencies[indexPath.row]
        
        if selectedCurrencies.contains(currencyName) {
                        
            print("Already exist")
            
        } else {
            
            selectedCurrencies.append(currencies[indexPath.row])
            
        }
        
        print(selectedCurrencies)
        
        if selectedCurrencies.count == 2 {
            
            guard let firstCurrency = selectedCurrencies.first else { return }
            guard let secondCurrency = selectedCurrencies.last else { return }
            
            guard let firstDescription = findDescription(isoCode: firstCurrency) else { return }
            guard let secondDescription = findDescription(isoCode: secondCurrency) else { return }
            
            let currenciesCombined = "\(firstCurrency)" + "\(secondCurrency)"
            
            let descriptionCombined = "\(firstDescription)" + "/" + "\(secondDescription)"
            
            print(currenciesCombined)
            print(descriptionCombined)
            //print(udArray)
            
            udArray.insert(currenciesCombined, at: 0)
            udArray.insert(descriptionCombined, at: 1)
            
            print(udArray)
            
            UserDefaults.selectedCurrencies = udArray
            
            //userDefaults.set(udArray, forKey: "currencies_selected")
            
            /// Pushing a new ViewController
            self.navigationController?.popToRootViewController(animated: true)
            
        } else if selectedCurrencies.count == 1 {
            
            guard let lastSelectedCurrency = selectedCurrencies.last else { return }
                        
            print(lastSelectedCurrency)
            
            let oddElements = stride(from: 0, to: udArray.count, by: 2).map { udArray[$0] }
                        
            let result = oddElements.filter({ $0.dropLast(3) == lastSelectedCurrency })
            
            print(result)
            
            for r in result {
                print(r)
                
                guard let index = currencies.lastIndex(of: String(r.dropFirst(3))) else { return }
                
                currencies = currencies.filter({ $0 != r.dropFirst(3) })
                
                print(currencies)
                
                let indexPathrow = IndexPath(item: index, section: 0)
                tableView.deleteRows(at: [indexPathrow], with: .fade)
                
                print(index)
            }
                
            print(currencies)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselect")
        
        let currencyName = currencies[indexPath.row]
        
        selectedCurrencies = selectedCurrencies.filter { $0 != currencyName }
        
        fetchListCurrencies()
        tableView.reloadData()
        
        print(selectedCurrencies)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if selectedCurrencies.count > 1 {
          print("mais do que 2")
            return nil
        }
        
        print("menor do que 2")
        
        
       return indexPath
    }

}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
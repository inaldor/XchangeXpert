//
//  CurrenciesTableViewController.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 29/02/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

//protocol Split {
//    func extractElement(entireString: String) -> [String?]
//}

class CurrenciesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var currencies: [String] = []
    var selectedCurrencies: [String] = []
 
    let userDefaults = UserDefaults.standard
    
    var udArray = UserDefaults.standard.stringArray(forKey: "currencies_selected") ?? []
    
    //let splitContainer: Split
    
    let currencyData = [CurrencyDetails(nameDescription: "Australian Dollar", isoCode: "AUD"), CurrencyDetails(nameDescription: "Bulgarian Lev", isoCode: "BGN"), CurrencyDetails(nameDescription: "Brazilian Real", isoCode: "BRL"), CurrencyDetails(nameDescription: "Canadian Dollar", isoCode: "CAD"), CurrencyDetails(nameDescription: "Swiss Franc", isoCode: "CHF"), CurrencyDetails(nameDescription: "Renminbi", isoCode: "CNY"), CurrencyDetails(nameDescription: "Czech Koruna", isoCode: "CZK"), CurrencyDetails(nameDescription: "Danish Krone", isoCode: "DKK"), CurrencyDetails(nameDescription: "Euro", isoCode: "EUR"), CurrencyDetails(nameDescription: "Pound Sterling", isoCode: "GBP"), CurrencyDetails(nameDescription: "Hong Kong Dollar", isoCode: "HKD"), CurrencyDetails(nameDescription: "Croatian Kuna", isoCode: "HRK"), CurrencyDetails(nameDescription: "Hungarian Forint", isoCode: "HUF"), CurrencyDetails(nameDescription: "Indonesian Rupiah", isoCode: "IDR"), CurrencyDetails(nameDescription: "Israeli New Shekel", isoCode: "ILS"), CurrencyDetails(nameDescription: "Indian Rupee", isoCode: "INR"), CurrencyDetails(nameDescription: "Icelandic Króna", isoCode: "ISK"), CurrencyDetails(nameDescription: "Japanese Yen", isoCode: "JPY"), CurrencyDetails(nameDescription: "South Korean Won", isoCode: "KRW"), CurrencyDetails(nameDescription: "Mexican Peso", isoCode: "MXN"), CurrencyDetails(nameDescription: "Malaysian Ringgit", isoCode: "MYR"), CurrencyDetails(nameDescription: "Norwegian Krone", isoCode: "NOK"), CurrencyDetails(nameDescription: "New Zealand Dollar", isoCode: "NZD"), CurrencyDetails(nameDescription: "Philippine Peso", isoCode: "PHP"), CurrencyDetails(nameDescription: "Polish Złoty", isoCode: "PLN"), CurrencyDetails(nameDescription: "Romanian Leu", isoCode: "RON"), CurrencyDetails(nameDescription: "Russian Ruble", isoCode: "RUB"), CurrencyDetails(nameDescription: "Swedish Krona", isoCode: "SEK"), CurrencyDetails(nameDescription: "Singapore Dollar", isoCode: "SGD"), CurrencyDetails(nameDescription: "Thai Baht", isoCode: "THB"), CurrencyDetails(nameDescription: "United States Dollar", isoCode: "USD"), CurrencyDetails(nameDescription: "South African Rand", isoCode: "ZAR")]
    
    //let currencyDataArray = UserDefaults.standard.stringArray(forKey: "currencies_available") ?? []
//
//    init() {
//        splitContainer = SplitString()
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchListCurrencies()
        
//        print(currenciesAvailable)
        //currenciesAvailable.

        //}
            
        print(udArray)
            
        
    }
    
    fileprivate func fetchListCurrencies() {

        do {
           let jsonURL = Bundle.main.url(forResource: "currencies", withExtension: "json")
           let jsonDecoder = JSONDecoder()
           let jsonData = try Data(contentsOf: jsonURL!)
           let jsonSentence = try jsonDecoder.decode([String].self, from: jsonData)
           currencies = jsonSentence

        } catch {
           print(error)
        }
        
    }
    
    func findDescription(isoCode: String) -> String? {
        
        //let currencyList = currencyData.map( { $0.isoCode })
        //let currencyDescription = currencyData.map( { $0.nameDescription })
                
        //for unit in currencyList {

//            print(unit)
//
//            if unit == isoCode {
//                print("equal")
//
//                guard let elementIndex = currencyList.firstIndex(of: unit) else { return nil }
//
//                return currencyDescription[elementIndex]
//            }
        //}
        
        for element in currencyData {
            
            if element.isoCode == isoCode {
                
                print("equal")
                
                //guard let elementIndex = currencyData.firstIndex(of: element) else { return nil }
                
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
        
//        let data = user UserDefaults.standard.value(forKey: "currencies_available") as! Data
//        guard let currencyData = try? JSONDecoder().decode(CurrencyDetails.self, from: data) else { return cell }
//
//
//        for iso in currencyData.isoCode {
//
//            print(iso)
//
//            if String(iso) == currencies[indexPath.row] {
//                print("equal")
//            }
//
//        }
        
        
//        let currencyDataArray = userDefaults.value(forKey: "currencies_available") as! Data
//
//        let currenciesAvailable = try? PropertyListDecoder().decode(Array<currencyDetails>.self, from: currencyDataArray)
//
//        let ok = currenciesAvailable.map( { } )
        //print(currenciesAvailable
        
//        if currencies[indexPath.row].contains(currencyData)
//
//        switch curr {
//
//
//        default:
//            print("ok")
//        }
        
        //let currencyList = currencyData.map( { $0.isoCode })
        
        for element in currencyData {
            
            if element.isoCode == currencies[indexPath.row] {
                
                cell.currencyNameDescriptionLabel.text = element.nameDescription
                cell.currencyImageView.image = UIImage(named: "\(element.nameDescription)")
                
            }
            
        }
        
//        switch currencies[indexPath.row] {
//
//        //case currencyDataArray[
//             let ok = splitContainer.extractElement(entireString: <#T##String#>)
//
//            case "AUD":
//                cell.currencyNameDescriptionLabel.text = "Australian Dollar"
//                cell.currencyImageView.image = UIImage(named: "Australian Dollar")
//
//            case "BGN":
//                cell.currencyNameDescriptionLabel.text = "Bulgarian Lev"
//                cell.currencyImageView.image = UIImage(named: "Bulgarian Lev")
//
//            case "BRL":
//                cell.currencyNameDescriptionLabel.text = "Brazilian Real"
//                cell.currencyImageView.image = UIImage(named: "Brazilian Real")
//
//            case "CAD":
//                cell.currencyNameDescriptionLabel.text = "Canadian Dollar"
//                cell.currencyImageView.image = UIImage(named: "Canadian Dollar")
//
//            case "CHF":
//                cell.currencyNameDescriptionLabel.text = "Swiss Franc"
//                cell.currencyImageView.image = UIImage(named: "Swiss Franc")
//
//            case "CNY":
//                cell.currencyNameDescriptionLabel.text = "Renminbi"
//                cell.currencyImageView.image = UIImage(named: "Renminbi")
//
//            case "CZK":
//                cell.currencyNameDescriptionLabel.text = "Czech Koruna"
//                cell.currencyImageView.image = UIImage(named: "Czech Koruna")
//
//            case "DKK":
//                cell.currencyNameDescriptionLabel.text = "Danish Krone"
//                cell.currencyImageView.image = UIImage(named: "Danish Krone")
//
//            case "EUR":
//                cell.currencyNameDescriptionLabel.text = "Euro"
//                cell.currencyImageView.image = UIImage(named: "Euro")
//
//            case "GBP":
//                cell.currencyNameDescriptionLabel.text = "Pound Sterling"
//                cell.currencyImageView.image = UIImage(named: "Pound Sterling")
//
//            case "HKD":
//                cell.currencyNameDescriptionLabel.text = "Hong Kong Dollar"
//                cell.currencyImageView.image = UIImage(named: "Hong Kong Dollar")
//
//            case "HRK":
//                cell.currencyNameDescriptionLabel.text = "Croatian Kuna"
//                cell.currencyImageView.image = UIImage(named: "Croation Kuna")
//
//            case "HUF":
//                cell.currencyNameDescriptionLabel.text = "Hungarian Forint"
//                cell.currencyImageView.image = UIImage(named: "Hungarian forint")
//
//            case "IDR":
//                cell.currencyNameDescriptionLabel.text = "Indonesian Rupiah"
//                cell.currencyImageView.image = UIImage(named: "Indonesian Rupiah")
//
//            case "ILS":
//                cell.currencyNameDescriptionLabel.text = "Israeli New Shekel"
//                cell.currencyImageView.image = UIImage(named: "Israeli New Shekel")
//
//            case "INR":
//                cell.currencyNameDescriptionLabel.text = "Indian Rupee"
//                cell.currencyImageView.image = UIImage(named: "Indian Rupee")
//
//            case "ISK":
//                cell.currencyNameDescriptionLabel.text = "Icelandic Króna"
//                cell.currencyImageView.image = UIImage(named: "Icelandic Krona")
//
//            case "JPY":
//                cell.currencyNameDescriptionLabel.text = "Japanese Yen"
//                cell.currencyImageView.image = UIImage(named: "Japanese Yen")
//
//            case "KRW":
//                cell.currencyNameDescriptionLabel.text = "South Korean Won"
//                cell.currencyImageView.image = UIImage(named: "South Korean Won")
//
//            case "MXN":
//                cell.currencyNameDescriptionLabel.text = "Mexican Peso"
//                cell.currencyImageView.image = UIImage(named: "Mexican Peso")
//
//            case "MYR":
//                cell.currencyNameDescriptionLabel.text = "Malaysian Ringgit"
//                cell.currencyImageView.image = UIImage(named: "Malaysian Ringgit")
//
//            case "NOK":
//                cell.currencyNameDescriptionLabel.text = "Norwegian Krone"
//                cell.currencyImageView.image = UIImage(named: "Norwegian Krone")
//
//            case "NZD":
//                cell.currencyNameDescriptionLabel.text = "New Zealand Dollar"
//                cell.currencyImageView.image = UIImage(named: "New Zealand Dollar")
//
//            case "PHP":
//                cell.currencyNameDescriptionLabel.text = "Philippine Peso"
//                cell.currencyImageView.image = UIImage(named: "Philippine Peso")
//
//            case "PLN":
//                cell.currencyNameDescriptionLabel.text = "Polish Złoty"
//                cell.currencyImageView.image = UIImage(named: "Polish Zloty")
//
//            case "RON":
//                cell.currencyNameDescriptionLabel.text = "Romanian Leu"
//                cell.currencyImageView.image = UIImage(named: "Romanian Leu")
//
//            case "RUB":
//                cell.currencyNameDescriptionLabel.text = "Russian Ruble"
//                cell.currencyImageView.image = UIImage(named: "Russian Ruble")
//
//            case "SEK":
//                cell.currencyNameDescriptionLabel.text = "Swedish Krona"
//                cell.currencyImageView.image = UIImage(named: "Swedish Krona")
//
//            case "SGD":
//                cell.currencyNameDescriptionLabel.text = "Singapore Dollar"
//                cell.currencyImageView.image = UIImage(named: "Singapore Dollar")
//
//            case "THB":
//                cell.currencyNameDescriptionLabel.text = "Thai Baht"
//                cell.currencyImageView.image = UIImage(named: "Thai Baht")
//
//            case "USD":
//                cell.currencyNameDescriptionLabel.text = "United States Dollar"
//                cell.currencyImageView.image = UIImage(named: "United States Dollar")
//
//            case "ZAR":
//                cell.currencyNameDescriptionLabel.text = "South African Rand"
//                cell.currencyImageView.image = UIImage(named: "South African Rand")
//
//            default:
//            print("Unknown")
//
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CurrenciesTableViewCell
        
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
            
            udArray.append(currenciesCombined)
            udArray.append(descriptionCombined)
            userDefaults.set(udArray, forKey: "currencies_selected")
            
            /// Pushing a new ViewController
            self.navigationController?.popToRootViewController(animated: true)
            
        } else if selectedCurrencies.count == 1 {
            
            guard let lastSelectedCurrency = selectedCurrencies.last else { return }
                        
            print(lastSelectedCurrency)
            
            //let currencyListSaved = udArray.filter({ $0 == $0.ind % 2 == 0 })
            let oddElements = stride(from: 0, to: udArray.count, by: 2).map { udArray[$0] }
            
            //print(oddA)
            
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

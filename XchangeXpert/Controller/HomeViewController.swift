//
//  HomeViewController.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 09/02/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

protocol Split {
    //func extractElement(entireString: String) -> [String?]
    func extractArrayElement(entireString: [String]) -> [String]
}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addCurrencyPairButton: UIButton!
    
    @IBOutlet weak var addCurrencyPairTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var addCurrencyPairHeightConstraint: NSLayoutConstraint!
    
    var rates: [Double] = []
    var currencyBase: [String] = []
    var currencyOutput: [String] = []
    
    var currencyBaseDesc: [String] = []
    var currencyOutputDesc: [String] = []
    var savedPairCurrencies: [String] = []
    
    var noRepeatControl = false
    var loadTableViewControl = true
    var timer: Timer!
    
    let userDefaults = UserDefaults.standard
    
    var splitContainer: Split
    
    required public init?(coder aDecoder: NSCoder) {
        splitContainer = SplitString()
        super.init(coder: aDecoder)
    }
    
//    init() {
//        splitContainer = SplitString()
//        super.init(coder: aDecoder)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//       super.init(coder: aDecoder)
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        noRepeatControl = false
        
        loadTableViewControl = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        
        //print(savedPairCurrenciesOdd)
        
        //let savedPairCurrenciesOdd = oddElements.filter({ $0.dropLast(3) == lastSelectedCurrency })
        
        manageCurrencies()
        
        if savedPairCurrencies.isEmpty {
            print("Empty")
            self.tableView.isHidden = true

            addCurrencyPairTopConstraint.constant = self.view.frame.size.height/3
            addCurrencyPairHeightConstraint.constant = 100

            addCurrencyPairButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
            addCurrencyPairButton.titleLabel?.numberOfLines = 3
            addCurrencyPairButton.titleLabel?.textAlignment = .center

            let mainTitle = "Add Currency Pair\n"
            let subtitle = "Choose a currency pair to compare their live rates"

            let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 39/255, green: 127/255, blue: 230/255, alpha: 1.0)]
            let thirdAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)]

            let firstString = NSMutableAttributedString()
            let secondString = NSAttributedString(string: mainTitle, attributes: secondAttributes)
            let thirdString = NSAttributedString(string: subtitle, attributes: thirdAttributes)

            firstString.append(secondString)
            firstString.append(thirdString)

            addCurrencyPairButton.setAttributedTitle(firstString, for: .normal)

            addCurrencyPairButton.imageEdgeInsets.bottom = 30
            addCurrencyPairButton.imageEdgeInsets.top = 3
            addCurrencyPairButton.imageEdgeInsets.left = 25
            addCurrencyPairButton.imageEdgeInsets.right = -285

            addCurrencyPairButton.titleEdgeInsets.bottom = -40
            addCurrencyPairButton.titleEdgeInsets.top = -10
            addCurrencyPairButton.titleEdgeInsets.left = -40
            addCurrencyPairButton.titleEdgeInsets.right = 0
        } else {
            print(" not Empty")
            self.tableView.isHidden = false

            addCurrencyPairTopConstraint.constant = 20
            addCurrencyPairHeightConstraint.constant = 40

            let mainTitle = " Add Currency Pair"

            let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 39/255, green: 127/255, blue: 230/255, alpha: 1.0)]

            let firstString = NSMutableAttributedString()
            let secondString = NSAttributedString(string: mainTitle, attributes: secondAttributes)

            firstString.append(secondString)

            addCurrencyPairButton.setAttributedTitle(firstString, for: .normal)

            addCurrencyPairButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
            addCurrencyPairButton.titleLabel?.numberOfLines = 3
            addCurrencyPairButton.titleLabel?.textAlignment = .center

            addCurrencyPairButton.imageEdgeInsets.bottom = 0
            addCurrencyPairButton.imageEdgeInsets.top = 0
            addCurrencyPairButton.imageEdgeInsets.left = 0
            addCurrencyPairButton.imageEdgeInsets.right = 0

            addCurrencyPairButton.titleEdgeInsets.bottom = 10
            addCurrencyPairButton.titleEdgeInsets.top = 0
            addCurrencyPairButton.titleEdgeInsets.left = 0
            addCurrencyPairButton.titleEdgeInsets.right = 0
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageCurrencies()
        
        fetchRates()
        
        //addDataOfCurrencies()
    }
    
    @objc func loop() {
        if noRepeatControl {
            timer.invalidate()
        } else {
            fetchRates()
        }
    }
    
    func manageCurrencies() {
        
        let savedPairs = userDefaults.stringArray(forKey: "currencies_selected") ?? []
        savedPairCurrencies = stride(from: 0, to: savedPairs.count, by: 2).map { savedPairs[$0] }
        
        print(savedPairCurrencies)
        
        let savedPairCurrenciesEven = stride(from: 1, to: savedPairs.count, by: 2).map { savedPairs[$0] }
        let savedCurrencyDescriptions = splitContainer.extractArrayElement(entireString: savedPairCurrenciesEven)
        
        print(savedCurrencyDescriptions)
        
        //print(ok)
        
        currencyBaseDesc = stride(from: 0, to: savedCurrencyDescriptions.count, by: 2).map { savedCurrencyDescriptions[$0] }
        currencyOutputDesc = stride(from: 1, to: savedCurrencyDescriptions.count, by: 2).map { savedCurrencyDescriptions[$0] }
        
        print(currencyBaseDesc)
        print(currencyOutputDesc)
        
    }

    //func addDataOfCurrencies() {
        
       
        
        //print(currencyData)
        
        //var udArray = UserDefaults.standard.stringArray(forKey: "currencies_selected") ?? []
        //let currencyDataArray = UserDefaults.standard.stringArray(forKey: "currencies_available") ?? []
       // let dataUserDefaults = userDefaults.stringArray(forKey: "currencies_available") ?? []
//
//        if let data = try? JSONEncoder().encode(currencyData) {
//            userDefaults.set(data, forKey: "currencies_available")
//        }
//
//        //userDefaults.set(currencyData, forKey:"currencies_available")
//
//        //userDefaults.set(currencyData, forKey: "currencies_available")
//
//    }
    
    func fetchRates() {
        
        //let savedPairs = userDefaults.stringArray(forKey: "currencies_selected") ?? []
        
        //let savedPairCurrenciesOdd = stride(from: 0, to: savedPairs.count, by: 2).map { savedPairs[$0] }

        
        /// Call for the Service to fetch the items from the API
        Service.shared.fetchItems(currencyPairs: savedPairCurrencies) { (items, error) in
                   
                /// Checking for errors after try to fetching the items
                if let error = error {
                   print("Failed to fetch items:", error)
                   return
                }
                
                if let items = items {
                    
                    print(self.savedPairCurrencies)
                    print(items)
                    
                    //guard let nada = value.firstIndex(of: items ) else { return }
                    
                    //let ok = items.map( { $0.value } )
                    
                    let itemsFiltered = items.filter { item in
                        self.savedPairCurrencies.contains(where: { $0 == item.key }
                    )}

                    print(itemsFiltered)
                    
                    let itemsFilteredSorted = itemsFiltered.sorted { self.savedPairCurrencies.firstIndex(of: $0.key)! < self.savedPairCurrencies.firstIndex(of: $1.key)! }
                    
                    print(itemsFilteredSorted)
                       
                    self.rates = itemsFilteredSorted.map( { $0.value } )
                    self.currencyBase = itemsFilteredSorted.map( { String($0.key.dropLast(3)) } )
                    self.currencyOutput = itemsFilteredSorted.map( { String($0.key.dropFirst(3)) } )
                    
                    if self.loadTableViewControl {
                        self.tableView.reloadData()
                        self.loadTableViewControl = false
                    }
                   
                    var indexOfElement = 0
                    
                    for _ in self.currencyBase {

                        let indexPathrow = IndexPath(item: indexOfElement, section: 0)
                        print(indexPathrow)

                        if let cell = self.tableView.cellForRow(at: indexPathrow) as? HomeViewCell {
                            // Update the cell
                            cell.rate.text = String(self.rates[indexPathrow.row])

                        }
                        indexOfElement += 1
                    }
                }
        }
        
    }

    @IBAction func addCurrencyPair(_ sender: UIButton) {
        
        noRepeatControl = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencyBase.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! HomeViewCell
        
        cell.currencyMain.text = currencyBase[indexPath.row]
        cell.currencyCompared.text = currencyOutput[indexPath.row]
        cell.rate.text = String(rates[indexPath.row])
        
        
//        for element in currencyData {
//
//            if element.isoCode == currencies[indexPath.row] {
//
//                cell.currencyNameDescriptionLabel.text = element.nameDescription
//                cell.currencyImageView.image = UIImage(named: "\(element.nameDescription)")
//
//            }
//
//        }
        
        //let savedPairs = userDefaults.stringArray(forKey: "currencies_selected") ?? []
        
        //let savedPairCurrenciesEven = stride(from: 1, to: savedPairs.count, by: 2).map { savedPairs[$0] }
        
        //print(savedPairCurrenciesEven)
        
        //let ok = splitContainer.extractElement(entireString: savedPairCurrenciesEven[indexPath.row])
        
        //print(ok)
        
        cell.currencyMainDescriptionLabel.text = currencyBaseDesc[indexPath.row]
        
        cell.currencyComparedDescriptionLabel.text = currencyOutputDesc[indexPath.row]
                
//        switch currencyOutput[indexPath.row] {
//
//            case "AUD":
//                cell.currencyComparedDescriptionLabel.text = "Australian Dollar"
//
//            case "BGN":
//                cell.currencyComparedDescriptionLabel.text = "Bulgarian Lev"
//
//            case "BRL":
//                cell.currencyComparedDescriptionLabel.text = "Brazilian Real"
//
//            case "CAD":
//                cell.currencyComparedDescriptionLabel.text = "Canadian Dollar"
//
//            case "CHF":
//                cell.currencyComparedDescriptionLabel.text = "Swiss Franc"
//
//            case "CNY":
//                cell.currencyComparedDescriptionLabel.text = "Renminbi"
//
//            case "CZK":
//                cell.currencyComparedDescriptionLabel.text = "Czech Koruna"
//
//            case "DKK":
//                cell.currencyComparedDescriptionLabel.text = "Danish Krone"
//
//            case "EUR":
//                cell.currencyComparedDescriptionLabel.text = "Euro"
//
//            case "GBP":
//                cell.currencyComparedDescriptionLabel.text = "Pound Sterling"
//
//            case "HKD":
//                cell.currencyComparedDescriptionLabel.text = "Hong Kong Dollar"
//
//            case "HRK":
//                cell.currencyComparedDescriptionLabel.text = "Croatian Kuna"
//
//            case "HUF":
//                cell.currencyComparedDescriptionLabel.text = "Hungarian Forint"
//
//            case "IDR":
//                cell.currencyComparedDescriptionLabel.text = "Indonesian Rupiah"
//
//            case "ILS":
//                cell.currencyComparedDescriptionLabel.text = "Israeli New Shekel"
//
//            case "INR":
//                cell.currencyComparedDescriptionLabel.text = "Indian Rupee"
//
//            case "ISK":
//                cell.currencyComparedDescriptionLabel.text = "Icelandic Króna"
//
//            case "JPY":
//                cell.currencyComparedDescriptionLabel.text = "Japanese Yen"
//
//            case "KRW":
//                cell.currencyComparedDescriptionLabel.text = "South Korean Won"
//
//            case "MXN":
//                cell.currencyComparedDescriptionLabel.text = "Mexican Peso"
//
//            case "MYR":
//                cell.currencyComparedDescriptionLabel.text = "Malaysian Ringgit"
//
//            case "NOK":
//                cell.currencyComparedDescriptionLabel.text = "Norwegian Krone"
//
//            case "NZD":
//                cell.currencyComparedDescriptionLabel.text = "New Zealand Dollar"
//
//            case "PHP":
//                cell.currencyComparedDescriptionLabel.text = "Philippine Peso"
//
//            case "PLN":
//                cell.currencyComparedDescriptionLabel.text = "Polish Złoty"
//
//            case "RON":
//                cell.currencyComparedDescriptionLabel.text = "Romanian Leu"
//
//            case "RUB":
//                cell.currencyComparedDescriptionLabel.text = "Russian Ruble"
//
//            case "SEK":
//                cell.currencyComparedDescriptionLabel.text = "Swedish Krona"
//
//            case "SGD":
//                cell.currencyComparedDescriptionLabel.text = "Singapore Dollar"
//
//            case "THB":
//                cell.currencyComparedDescriptionLabel.text = "Thai Baht"
//
//            case "USD":
//                cell.currencyComparedDescriptionLabel.text = "United States Dollar"
//
//            case "ZAR":
//                cell.currencyComparedDescriptionLabel.text = "South African Rand"
//
//            default:
//            print("Unknown")
//
//        }
//
//        switch currencyBase[indexPath.row] {
//
//            case "AUD":
//                cell.currencyMainDescriptionLabel.text = "Australian Dollar"
//
//            case "BGN":
//                cell.currencyMainDescriptionLabel.text = "Bulgarian Lev"
//
//            case "BRL":
//                cell.currencyMainDescriptionLabel.text = "Brazilian Real"
//
//            case "CAD":
//                cell.currencyMainDescriptionLabel.text = "Canadian Dollar"
//
//            case "CHF":
//                cell.currencyMainDescriptionLabel.text = "Swiss Franc"
//
//            case "CNY":
//                cell.currencyMainDescriptionLabel.text = "Renminbi"
//
//            case "CZK":
//                cell.currencyMainDescriptionLabel.text = "Czech Koruna"
//
//            case "DKK":
//                cell.currencyMainDescriptionLabel.text = "Danish Krone"
//
//            case "EUR":
//                cell.currencyMainDescriptionLabel.text = "Euro"
//
//            case "GBP":
//                cell.currencyMainDescriptionLabel.text = "Pound Sterling"
//
//            case "HKD":
//                cell.currencyMainDescriptionLabel.text = "Hong Kong Dollar"
//
//            case "HRK":
//                cell.currencyMainDescriptionLabel.text = "Croatian Kuna"
//
//            case "HUF":
//                cell.currencyMainDescriptionLabel.text = "Hungarian Forint"
//
//            case "IDR":
//                cell.currencyMainDescriptionLabel.text = "Indonesian Rupiah"
//
//            case "ILS":
//                cell.currencyMainDescriptionLabel.text = "Israeli New Shekel"
//
//            case "INR":
//                cell.currencyMainDescriptionLabel.text = "Indian Rupee"
//
//            case "ISK":
//                cell.currencyMainDescriptionLabel.text = "Icelandic Króna"
//
//            case "JPY":
//                cell.currencyMainDescriptionLabel.text = "Japanese Yen"
//
//            case "KRW":
//                cell.currencyMainDescriptionLabel.text = "South Korean Won"
//
//            case "MXN":
//                cell.currencyMainDescriptionLabel.text = "Mexican Peso"
//
//            case "MYR":
//                cell.currencyMainDescriptionLabel.text = "Malaysian Ringgit"
//
//            case "NOK":
//                cell.currencyMainDescriptionLabel.text = "Norwegian Krone"
//
//            case "NZD":
//                cell.currencyMainDescriptionLabel.text = "New Zealand Dollar"
//
//            case "PHP":
//                cell.currencyMainDescriptionLabel.text = "Philippine Peso"
//
//            case "PLN":
//                cell.currencyMainDescriptionLabel.text = "Polish Złoty"
//
//            case "RON":
//                cell.currencyMainDescriptionLabel.text = "Romanian Leu"
//
//            case "RUB":
//                cell.currencyMainDescriptionLabel.text = "Russian Ruble"
//
//            case "SEK":
//                cell.currencyMainDescriptionLabel.text = "Swedish Krona"
//
//            case "SGD":
//                cell.currencyMainDescriptionLabel.text = "Singapore Dollar"
//
//            case "THB":
//                cell.currencyMainDescriptionLabel.text = "Thai Baht"
//
//            case "USD":
//                cell.currencyMainDescriptionLabel.text = "United States Dollar"
//
//            case "ZAR":
//                cell.currencyMainDescriptionLabel.text = "South African Rand"
//
//            default:
//            print("Unknown")
//
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        //var savedPairs = userDefaults.stringArray(forKey: "currencies_selected") ?? []
        
        //var savedPairCurrenciesOdd = stride(from: 0, to: savedPairs.count, by: 2).map { savedPairs[$0] }
        
        if (editingStyle == .delete) {
           
            print(indexPath)
            
            //print(savedPairs)
            
            currencyBaseDesc.remove(at: indexPath.row)
            currencyOutputDesc.remove(at: indexPath.row)
            savedPairCurrencies.remove(at: indexPath.row)
           
            print(currencyBaseDesc)
            print(currencyOutputDesc)
            print(savedPairCurrencies)
            
            //savedPairs.remove(at: indexPath.row)
            //savedPairs.remove(at: indexPath.row)
           
            userDefaults.set(savedPairCurrencies, forKey: "currencies_selected")
            
            currencyBase.remove(at: indexPath.row)
            currencyOutput.remove(at: indexPath.row)
            rates.remove(at: indexPath.row)
            
            print(currencyBase)
            print(currencyOutput)
            print(rates)

            tableView.deleteRows(at: [indexPath], with: .fade)
                    
            self.tableView.reloadData()
        }
    }
}

//
//  HomeViewController.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 09/02/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

protocol Management {
    //func extractElement(entireString: String) -> [String?]
    func extractSavedCurrencies() -> [String]
    func extractCurrencyBaseDesc() -> [String]
    func extractCurrencyQuoteDesc() -> [String]
    func removeArrayElement(position: Int) -> [String]
    func formatRate(rate: Double) -> NSAttributedString
}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak private var addCurrencyPairButton: UIButton!
    
    @IBOutlet weak private var addCurrencyPairTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var addCurrencyPairHeightConstraint: NSLayoutConstraint!
    
    private var rates: [Double] = []
    private var currencyBase: [String] = []
    private var currencyOutput: [String] = []
    
    private var currencyBaseDesc: [String] = []
    private var currencyQuoteDesc: [String] = []
    private var savedPairCurrencies: [String] = []
    
    private var noRepeatControl = false
    private var loadTableViewControl = true
    private var timer: Timer!
    
    //let userDefaults = UserDefaults.standard
    
    private var manageContainer: Management
    
    required public init?(coder aDecoder: NSCoder) {
        manageContainer = ManageCurrencies()
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
        
        //print(savedPairCurrenciesOdd)
        
        //let savedPairCurrenciesOdd = oddElements.filter({ $0.dropLast(3) == lastSelectedCurrency })
        
        //manageCurrencies()
        
        savedPairCurrencies = manageContainer.extractSavedCurrencies()
        currencyBaseDesc = manageContainer.extractCurrencyBaseDesc()
        currencyQuoteDesc = manageContainer.extractCurrencyQuoteDesc()
        
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
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //manageCurrencies()
        
        savedPairCurrencies = manageContainer.extractSavedCurrencies()
        currencyBaseDesc = manageContainer.extractCurrencyBaseDesc()
        currencyQuoteDesc = manageContainer.extractCurrencyQuoteDesc()
        
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
    
//    func manageCurrencies() {
//
//        let savedPairs = UserDefaults.selectedCurrencies
//        savedPairCurrencies = stride(from: 0, to: savedPairs.count, by: 2).map { savedPairs[$0] }
//
//        print(savedPairCurrencies)
//
//        let savedPairCurrenciesEven = stride(from: 1, to: savedPairs.count, by: 2).map { savedPairs[$0] }
//        let savedCurrencyDescriptions = splitContainer.extractArrayElement(entireString: savedPairCurrenciesEven)
//
//        print(savedCurrencyDescriptions)
//
//        //print(ok)
//
//        currencyBaseDesc = stride(from: 0, to: savedCurrencyDescriptions.count, by: 2).map { savedCurrencyDescriptions[$0] }
//        currencyOutputDesc = stride(from: 1, to: savedCurrencyDescriptions.count, by: 2).map { savedCurrencyDescriptions[$0] }
//
//        print(currencyBaseDesc)
//        print(currencyOutputDesc)
//
//    }

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
    
    private func fetchRates() {
        
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
                            
                            let formattedString = self.manageContainer.formatRate(rate: self.rates[indexPathrow.row])

                            cell.rate.attributedText = formattedString
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
        
        //print(currencyBaseDesc)
          //      print(currencyQuoteDesc)
            //    print(savedPairCurrencies)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! HomeViewCell
        
        cell.currencyMain.text = currencyBase[indexPath.row]
        cell.currencyCompared.text = currencyOutput[indexPath.row]
        cell.currencyMainDescriptionLabel.text = currencyBaseDesc[indexPath.row]
        cell.currencyComparedDescriptionLabel.text = currencyQuoteDesc[indexPath.row]
        
        let formattedString = self.manageContainer.formatRate(rate: rates[indexPath.row])
        cell.rate.attributedText = formattedString
        
//        let rateWithoutFormat = rates[indexPath.row]
//        //if rateWithoutFormat
//
//        let rateFormatted = round(1000*rateWithoutFormat)/1000
//        print(rateFormatted)
        
        
        
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
            
            UserDefaults.selectedCurrencies = manageContainer.removeArrayElement(position: indexPath.row)
            
            currencyBaseDesc.remove(at: indexPath.row)
            currencyQuoteDesc.remove(at: indexPath.row)
            savedPairCurrencies.remove(at: indexPath.row)
            
            //savedPairs.remove(at: indexPath.row)
            //savedPairs.remove(at: indexPath.row)
           
            //UserDefaults.selectedCurrencies = savedPairCurrencies
            
            //userDefaults.set(savedPairCurrencies, forKey: "currencies_selected")
            
            currencyBase.remove(at: indexPath.row)
            currencyOutput.remove(at: indexPath.row)
            rates.remove(at: indexPath.row)
            
            print(UserDefaults.selectedCurrencies)
            
            print(currencyBase)
            print(currencyOutput)
            print(rates)
            
            print(currencyBaseDesc)
            print(currencyQuoteDesc)
            print(savedPairCurrencies)

            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //savedPairCurrencies = manageContainer.extractSavedCurrencies()
            //currencyBaseDesc = manageContainer.extractCurrencyBaseDesc()
            //currencyQuoteDesc = manageContainer.extractCurrencyQuoteDesc()
                    
            //self.tableView.reloadData()
        }
    }
}

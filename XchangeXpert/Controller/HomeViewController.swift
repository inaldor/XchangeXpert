//
//  HomeViewController.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 09/02/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addCurrencyPairButton: UIButton!
    
    @IBOutlet weak var addCurrencyPairTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var addCurrencyPairHeightConstraint: NSLayoutConstraint!
    
    var rates: [Double] = []
    var currencyBase: [String] = []
    var currencyOutput: [String] = []
    
    var noRepeatControl = false
    var loadTableViewControl = true
    var timer: Timer!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        
        noRepeatControl = false
        
        loadTableViewControl = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        
        let savedPairs = userDefaults.stringArray(forKey: "currencies_selected") ?? []
           
           if savedPairs.isEmpty {
                print("Empty")
                self.tableView.isHidden = true
//                for constraint in self.view.constraints {
//                    if constraint.identifier == "addPairButtonTopConstraint" {
//                        constraint.constant = self.view.frame.size.height/3
//                    }
//                }
            
            //addCurrencyPairButton.frame.size = CGSize(width: 350, height: 100)
            
            //self.view.heght
            
            addCurrencyPairTopConstraint.constant = self.view.frame.size.height/3
            addCurrencyPairHeightConstraint.constant = 100
            
            addCurrencyPairButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
            addCurrencyPairButton.titleLabel?.numberOfLines = 3
            addCurrencyPairButton.titleLabel?.textAlignment = .center
            
            addCurrencyPairButton.setTitle("Add Currency Pair\nChoose a Currency pair to compare their live rates", for: .normal)
           
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
//                for constraint in self.view.constraints {
//                    if constraint.identifier == "addPairButtonTopConstraint" {
//                       constraint.constant = 20
//                    }
//                }
            
            addCurrencyPairTopConstraint.constant = 20
            addCurrencyPairHeightConstraint.constant = 40
            
            addCurrencyPairButton.setTitle("  Add Currency Pair", for: .normal)
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
        
        fetchRates()
    }
    
    @objc func loop() {
        if noRepeatControl {
            timer.invalidate()
        } else {
            fetchRates()
        }
    }

    func fetchRates() {
        
        let savedPairs = userDefaults.stringArray(forKey: "currencies_selected") ?? []
//
//        if savedPairs.isEmpty {
//            print("Empty")
//            for constraint in self.view.constraints {
//                if constraint.identifier == "addPairButtonTopConstraint" {
//                    constraint.constant = 50
//                }
//            }
//        }
        
        /// Call for the Service to fetch the items from the API
        Service.shared.fetchItems(currencyPairs: savedPairs) { (items, error) in
                   
                /// Checking for errors after try to fetching the items
                if let error = error {
                   print("Failed to fetch items:", error)
                   return
                }
                
                if let items = items {
                    
                    print(savedPairs)
                    print(items)
                    
                    //guard let nada = value.firstIndex(of: items ) else { return }
                    
                    //let ok = items.map( { $0.value } )
                    
                    let itemsFiltered = items.filter { item in
                        savedPairs.contains(where: { $0 == item.key }
                    )}

                    print(itemsFiltered)
                    
                    let itemsFilteredSorted = itemsFiltered.sorted { savedPairs.firstIndex(of: $0.key)! < savedPairs.firstIndex(of: $1.key)! }
                    
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        var savedPairs = userDefaults.stringArray(forKey: "currencies_selected") ?? []
        
        if (editingStyle == .delete) {
           
            print(indexPath)
           
            savedPairs.remove(at: indexPath.row)
           
            userDefaults.set(savedPairs, forKey: "currencies_selected")
            
            currencyBase.remove(at: indexPath.row)
            currencyOutput.remove(at: indexPath.row)
            rates.remove(at: indexPath.row)
            
            print(currencyBase)
            print(currencyOutput)
            print(rates)

            tableView.deleteRows(at: [indexPath], with: .fade)
                    
            print(savedPairs)
            self.tableView.reloadData()
        }
    }
}

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
    
    
    //var rates: [String:Double] = [:]
    var rates: [Double] = []
    var currencyBase: [String] = []
    var currencyOutput: [String] = []
    
    //let myTableView = UITableView()
    /// Variable to store the ID of the selected item
    //var currencyPairs: [String:Double] = [:]
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchRates()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        //self.myTableView.delegate = self
        //self.myTableView.dataSource = self
        
        //myTableView.delegate = self
        //myTableView.dataSource = self
        //tableView.delegate = self
        //tableView.dataSource = self
        
        //guard let currenciesSelected = UserDefaults.currenciesSelected? else { return }
        
        //print(currenciesSelected)
        
        //print(UserDefaults.standard.intArray)

        
//        do {
//            let jsonURL = Bundle.main.url(forResource: "currencies", withExtension: "json")
//            let jsonDecoder = JSONDecoder()
//            let jsonData = try Data(contentsOf: jsonURL!)
//            let jsonSentence = try jsonDecoder.decode([String].self, from: jsonData)
//            currencies = jsonSentence
//            //debugPrint(currencies[1])
//            //print(currencies.count)
//
//        } catch {
//            print(error)
//        }

//        do {
//            let data = try Data(contentsOf: Bundle.main.url(forResource: "currencies", withExtension: "json")!)
//                do {
//                    currencies = try JSONDecoder().decode(Currencies.self, from: data)
//                } catch {
//                    print("Failed to decode:")
//                }
//        } catch {
//            print("ok")
//        }
//        do {
//           let data = try Data(contentsOf: Bundle.main.url(forResource: "currencies", withExtension: "json")!)
//            currencies = try JSONDecoder().decode([Currencies].self, from: data)
//            //tableView.reloadData()
//        } catch {
//            print(error)
//        }
//
        
//        init(from decoder: Decoder) throws {
//            var container = try decoder.unkeyedContainer()
//            let values = try container.decode([String].self)
//            self.isoCode = values
//        }
        
//        if let url = Bundle.main.url(forResource: currencies, withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                var container = try decoder.unkeyedContainer()
//                let values = try container.dequeueReusableCell
//                let jsonData =
//                //let jsonData = try decoder.decode(ResponseData.self, from: data)
//                return jsonData.person
//            } catch {
//                print("error:\(error)")
//            }
//        }
//        return nil
        
//        if let url = Bundle.main.url(forResource: currencies, withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                decoder.unkeyedContainer
//                //let decoderok = try decoder.unkeyedContainer()
//                let jsonData = try decoder.decode(Currencies, from: data)
//                return jsonData.person
//            } catch {
//                print("error:\(error)")
//            }
//        }
        //return nil
        

    }

    func fetchRates() {
        
        //rates = [:]
        
        let userDefaults = UserDefaults.standard
        let value = userDefaults.stringArray(forKey: "currencies_selected") ?? []
        print(value)
        
        //let array = ["GBPUSD","GBPBRL","EURUSD","USDBRL"]
        
        /// Call for the Service to fetch the items from the API
        Service.shared.fetchItems(currencyPairs: value) { (items, error) in
                   
                /// Checking for errors after try to fetching the items
                if let error = error {
                   print("Failed to fetch items:", error)
                   return
                }
                
                if let items = items {
                    
                    //guard let ite = items else { return }
                    
                    //self.rates = items
                        
                    //print(items)
                    
                    //self.itemsArray =  ite.items.map( { $0 } )

                    self.rates = items.map( { $0.value } )
                    
                    self.currencyBase = items.map( { String($0.key.dropLast(3)) } )
                    //self.currencyBase.dropLast(3)
                    
                    self.currencyOutput = items.map( { String($0.key.dropFirst(3)) } )
                    //self.currencyOutput.dropFirst(3)
                    
                    print(items)
                    print(self.rates)
                    print(self.currencyBase)
                    print(self.currencyOutput)
                    /// Sharing the ID of the item selected with other ViewController
                    //let viewController = HomeViewController()
                    //viewController.currencyPairs = items
                    
                    /// Pushing a new ViewController
                    //self.navigationController?.popToRootViewController(animated: true)
                    
                    // .tableView.reloadData()
                    
                    self.tableView.reloadData()
                    
                    //self.myTableView.reloadData()
                }
                
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencyBase.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! HomeViewCell
        
        
        //cell.currencyMain.text = "ok"
        
        cell.currencyMain.text = currencyBase[indexPath.row]
        cell.currencyCompared.text = currencyOutput[indexPath.row]
        cell.rate.text = String(rates[indexPath.row])
        
        //cell.currencyMainLabel.text = "ok"
        //cell.currencyComparedLabel.text = "ok2"
        //cell.rateLabel.text = "ok3"
        
        //cell.currencyMainLabel.text = rates[indexPath.row]
        //    cell.currencyComparedLabel.text =
        //    cell.rateLabel.text =
        
    //
            
            //cell.currencyName.text = "ok"
            
            //cell.currencyName.text = "ok"
            
            //cell.textLabel?.text = "ok"
            
            //currencyName.text = "ok"
            
            //currencyName.text = "ok"
            
            
            //cell.contentView.te currencyName.text = ce
    //        //let itemViewModel = itemViewModels[indexPath.row]
    //        let item = itemsArray[indexPath.row]
    //
    //        cell.idLabel.text = String(item.id)
    //        cell.titleLabel.text = item.title
    //        cell.subtitleLabel.text = item.subtitle
    //        cell.dateLabel.text = item.date
    //
            return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        let ok = itemsArray[indexPath.row].id
    //
    //        let vc = ItemDetailViewController()
    //        vc.text = String(ok)
    //
    //        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
}

//
//  CurrenciesTableViewController.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 29/02/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class CurrenciesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var currencies: [String] = []
    var selectedCurrencies: [String] = []
    //var cellsSelected = [Cell]()
 
    let userDefaults = UserDefaults.standard
    var udArray = UserDefaults.standard.stringArray(forKey: "currencies_selected") ?? []
    //var  = userDefaults.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.allowsMultipleSelection = true
        //tableView.allowsMultipleSelectionDuringEditing = true
    
        fetchListCurrencies()
        //fetchData()
                
    }
    
    fileprivate func fetchListCurrencies() {

        do {
           let jsonURL = Bundle.main.url(forResource: "currencies", withExtension: "json")
           let jsonDecoder = JSONDecoder()
           let jsonData = try Data(contentsOf: jsonURL!)
           let jsonSentence = try jsonDecoder.decode([String].self, from: jsonData)
           currencies = jsonSentence
           //debugPrint(currencies[1])
           //print(currencies.count)

        } catch {
           print(error)
        }
        
    }
    
    fileprivate func fetchData() {
//        Service.shared.fetchItemDetails { (itemDetail, error) in
//            if let error = error {
//                print("Failed to fetch items:", error)
//                return
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CurrenciesTableViewCell
        
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
//
        //cell.currencyName.text = "ok"
        
        cell.currencyName.text = currencies[indexPath.row]
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CurrenciesTableViewCell
        
//        if cell.isSelected == true {
//            print("desmarcando")
////        } else {
////            print("marcando")
////        }
//        }
//
//            if cell.isSelected == false {
//                print("marcando")
//            }
        
//        if cell.isSelected != true {
//            print("entrou")
//            //cellsSelected[indexPath.row].isSelected = false
//        }
        //if cell.
        
//        if selectedCurrencies.count <= 1 {
//            selectedCurrencies.append(currencies[indexPath.row])
//        } else {
//            print("lotado")
//
//        }
//
//
//        let userDefaults = UserDefaults.standard
//        let value = userDefaults.stringArray(forKey: "currencies_selected") ?? []
//        print(value)
//
        //print(selectedCurrencies)
        
        
        
        
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
            
            let currenciesCombined = "\(firstCurrency)" + "\(secondCurrency)"
            
            print(currenciesCombined)
            
            //UserDefaults.standard.setCurrencies(value: <#T##[String]#>)
            
            //UserDefaults.currenciesSelected?.append(currenciesCombined)
            
//            let usD = UserDefaults.standard
//            var urls = usD.intArray
//            urls.append(currenciesCombined)
//            usD.intArray
            
            udArray.append(currenciesCombined)
            userDefaults.set(udArray, forKey: "currencies_selected")
            
            /// Pushing a new ViewController
            self.navigationController?.popToRootViewController(animated: true)
            
        } else if selectedCurrencies.count == 1 {
            
            guard let lastSelectedCurrency = selectedCurrencies.last else { return }
                        
            print(lastSelectedCurrency)
            
            //let ok = udArray.dropLast(3)
            
            //print(ok)
            
            let result = udArray.filter({ $0.dropLast(3) == lastSelectedCurrency })
            
            //contains(where: { $0.dropLast(3) == "BGN" })
            
            //let ok = ["BGN","IDR"]
            
            print(result)
            
            //et ok = result.map( { $0 })
            
            //let ok = result.map( { })
              
            //print(ok)
                
            //let sdok = currencies.filter({ $0.dropLast(3) != ok })
            
            for r in result {
                print(r)
                
                guard let index = currencies.lastIndex(of: String(r.dropFirst(3))) else { return }
                
                currencies = currencies.filter({ $0 != r.dropFirst(3) })
                
                print(currencies)
                
                let indexPathrow = IndexPath(item: index, section: 0)
                tableView.deleteRows(at: [indexPathrow], with: .fade)
                
                print(index)
            }
                
            //currencies = currencies.filter({ $0.dropLast(3) != result })
            
            //currencies = currencies.filter { !result.contains($0) }
            
            print(currencies)
            
//            if udArray.dropLast(3).contains(selectedCurrencies.last!) {
//                print("possui")
//            } else {
//
//                print("nao possui")
//            }
            
        }
//        let ok = itemsArray[indexPath.row].id
//
//        let vc = ItemDetailViewController()
//        vc.text = String(ok)
//        
//        navigationController?.pushViewController(vc, animated: true)
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

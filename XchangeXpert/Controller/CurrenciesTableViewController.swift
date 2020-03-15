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
    var cellsSelected = [Cell]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.allowsMultipleSelection = true
        //tableView.allowsMultipleSelectionDuringEditing = true
        
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
        
     
        fetchItems()
        fetchData()
                
    }
    
    fileprivate func fetchItems() {
//        Service.shared.fetchItems { (items, error) in
//            if let error = error {
//                print("Failed to fetch items:", error)
//                return
//            }
//
//            guard let ite = items else { return }
//
//            self.itemsArray =  ite.items.map( { $0 } )
//
//            self.itemsArray = self.itemsArray.sorted(by: { $0.id < $1.id })
//
//            self.itemUnique?.id = 32
//
//            self.tableView.reloadData()
//        }
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
        
        let currencyName = currencies[indexPath.row]
        
        if selectedCurrencies.contains(currencyName) {
                        
            print("Already exist")
            
        } else {
            
            selectedCurrencies.append(currencies[indexPath.row])
            
        }
        
        print(selectedCurrencies)
//        
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

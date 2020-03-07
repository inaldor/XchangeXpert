//
//  CurrenciesTableViewController.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 29/02/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class CurrenciesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CurrenciesTableViewCell
//
        
        //cell.currencyName.text = "ok"
        
        cell.currencyName.text = "ok"
        
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

}

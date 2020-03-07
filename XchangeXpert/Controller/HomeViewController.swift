//
//  HomeViewController.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 09/02/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //var currencies = [Currencies]()
    
    var currencies: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let jsonURL = Bundle.main.url(forResource: "currencies", withExtension: "json")
            let jsonDecoder = JSONDecoder()
            let jsonData = try Data(contentsOf: jsonURL!)
            let jsonSentence = try jsonDecoder.decode([String].self, from: jsonData)
            currencies = jsonSentence
            debugPrint(currencies[1])
            print(currencies.count)

        } catch {
            print(error)
        }

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


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! HomeTableViewCell
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
}

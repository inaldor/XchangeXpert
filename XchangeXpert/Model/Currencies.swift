//
//  Currencies.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 01/03/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

//import Foundation
//
//struct Currencies: Decodable {
//
//    // MARK: Properties
//    let isoCode: String
//
////    init(from decoder: Decoder) throws {
////        var container = try decoder.unkeyedContainer()
////        let values = try container.decode([String].self)
////        self.isoCode = values
////    }
//}



import Foundation

//struct DynamicKey: CodingKey {
//
//     var stringValue: String
//
//      init?(stringValue: String) {
//        self.stringValue = stringValue
//      }
//
//      var intValue: Int? {
//        return nil
//      }
//
//      init?(intValue: Int) {
//        return nil
//      }
//
//}

struct Rates: Decodable {
    
    // MARK: Properties
    
    var isoCode: [Decimal]
//
//    init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: DynamicKey.self)
//
//        for key in container.allKeys {
//            do {
//
//                if let keyValue = DynamicKey(stringValue: key.stringValue) {
//                    let ok = try container.decode(Decimal.self, forKey: keyValue)
//                    self.isoCode.append(ok)
//                }
//
//            } catch {
//                print("error")
//            }
//
//
//        }
//
        
        
//
//        self.additionalProperties = [String: ProductDescription]()
//        for key in container.allKeys {
//            do {
//
//
//                if let keyValue = CustomCodingKeys(stringValue: key.stringValue) {
//
//
//                    if  keyValue.stringValue == "disclaimersHtml" {
//                        self.disclaimersHtml = try container.decodeIfPresent(String.self, forKey: keyValue)
//                    }
//
//                    self.additionalProperties?[keyValue.stringValue] = try container.decodeIfPresent(ProductDescription.self, forKey: keyValue)
//                }
//
//
//
//
//            } catch {
//                // Silently ignore the error
//            }
        
    }
      
        //var isoCode: Decimal
//        var container = try decoder.unkeyedContainer()
//        let subContainer = try container.nestedContainer(keyedBy: DynamicKey.self)
//        for key in subContainer.allKeys {
//            let code = try subContainer.decode(<#T##type: Double.Type##Double.Type#>, forKey: DynamicKey.self)
//            self.users.append(user)
//        }
    
//        let dynamicKeysContainer = try decoder.container(keyedBy: DynamicKey.self)
//
//        try dynamicKeysContainer.allKeys.forEach { key in
//            isoCode = try dynamicKeysContainer.decode(Decimal.self, forKey: key)
//        }
//
//
//        self.is
        
//        let container = try decoder.container(keyedBy: DynamicKey.self)
//
//        for key in container.allKeys {
//            let value = try container.decode(Decimal.self, forKey: DynamicKey(stringValue: key.stringValue)!)
//            self.isoCode.append(value)// = value
//        }
//
//    }
 
//    init(from decoder: Decoder) throws {
//        let dynamicKeysContainer = try decoder.container(keyedBy: DynamicKey.self)
//        var role: Role = .unknown
//        try dynamicKeysContainer.allKeys.forEach { key in
//            switch key.stringValue {
//            case "isAdmin" where try dynamicKeysContainer.decode(Bool.self, forKey: key):
//                role = .admin
//            case "isViewer" where try dynamicKeysContainer.decode(Bool.self, forKey: key):
//                role = .viewer
//            default: break
//            }
//        }
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.surname = try container.decode(String.self, forKey: .surname)
//        self.age = try container.decode(Int.self, forKey: .age)
//        self.role = role
//    }
    
//}


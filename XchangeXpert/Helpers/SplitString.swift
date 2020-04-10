//
//  SplitString.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 08/04/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class SplitString: Split {
//    
//    func extractElement(entireString: String) -> [String?] {
//        
//        let elements = entireString.split(separator: "/")
//        var arrayElements: [String] = []
//        
//        for x in 0..<elements.count {
//            arrayElements.append(String(elements[x]))
//            //let resultElement = elements[x]
//        }
//        
//        return arrayElements
//    }
    
    func extractArrayElement(entireString: [String]) -> [String] {
        
        var arrayElements: [String] = []
        
        for r in entireString {
            
            let element = r.split(separator: "/")
            
            for x in 0..<element.count {
                arrayElements.append(String(element[x]))
                //let resultElement = elements[x]
            }
        }
        
        print(arrayElements)
        
        return arrayElements
    }
}

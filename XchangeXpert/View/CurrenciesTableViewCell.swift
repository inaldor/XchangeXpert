//
//  CurrenciesTableViewCell.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 01/03/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class CurrenciesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    
}

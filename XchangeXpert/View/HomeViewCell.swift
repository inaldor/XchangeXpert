//
//  HomeViewCell.swift
//  XchangeXpert
//
//  Created by Inaldo Ramos Ribeiro on 22/03/2020.
//  Copyright © 2020 Inaldo's Software Development. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyMain: UILabel!
    @IBOutlet weak var currencyCompared: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var currencyMainDescriptionLabel: UILabel!
    @IBOutlet weak var currencyComparedDescriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

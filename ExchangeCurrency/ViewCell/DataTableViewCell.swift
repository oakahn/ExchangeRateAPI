//
//  DataTableViewCell.swift
//  ExchangeCurrency
//
//  Created by chayarak on 30/3/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var nameCurrency: UILabel!
    @IBOutlet weak var rateCurrency: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

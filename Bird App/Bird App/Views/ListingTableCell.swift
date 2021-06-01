//
//  ListingTableCell.swift
//  Bird App
//
//  Created by TCS on 20/05/2021.
//

import UIKit

class ListingTableCell: UITableViewCell {
    override class func description() -> String {
        return "ListingCell"
    }
    @IBOutlet weak var txtLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//
//  ProductTableViewCell.swift
//  testtgs
//
//  Created by Manuel Landaverde on 7/7/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productName.text = ""
        descriptionLabel.text = ""
        priceLabel.text = ""
        categoryLabel.text = ""
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}

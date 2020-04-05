//
//  ItemTableViewCell.swift
//  ExtentionBooksApp
//
//  Created by Rentaro on 2020/04/05.
//  Copyright © 2020 Rentaro. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        bookImage.image = nil
    }

}

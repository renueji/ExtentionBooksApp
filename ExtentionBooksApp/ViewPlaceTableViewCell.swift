//
//  ViewPlaceTableViewCell.swift
//  ExtentionBooksApp
//
//  Created by Rentaro on 2020/04/08.
//  Copyright © 2020 Rentaro. All rights reserved.
//

import UIKit

class ViewPlaceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var shisetsu: UILabel!
    @IBOutlet weak var jusho: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
    }

}

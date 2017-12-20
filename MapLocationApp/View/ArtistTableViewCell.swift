//
//  ArtistTableViewCell.swift
//  MapLocationApp
//
//  Created by Mobile Developer on 12/8/17.
//  Copyright © 2017 Jin Xing. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    @IBOutlet var cell_Title: UILabel!
    @IBOutlet var cell_Artist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

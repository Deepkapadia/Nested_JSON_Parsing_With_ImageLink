//
//  CustomCell.swift
//  NEstedJsonParsing_WithSwift_Codable
//
//  Created by DeEp KapaDia on 28/01/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var IMG: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  contactCell.swift
//  Contacts
//
//  Created by Burak İmdat on 26.08.2021.
//  Copyright © 2021 Furkan Sabaz. All rights reserved.
//

import UIKit

class contactCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

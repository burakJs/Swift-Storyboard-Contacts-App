//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Burak İmdat on 26.08.2021.
//  Copyright © 2021 Furkan Sabaz. All rights reserved.
//

import UIKit

protocol ContactDetailControllerDelegate {
    func markAsFavoriteContact(contact: Contact)
}

class ContactDetailViewController: UITableViewController {
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblZipCode: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    var contact: Contact?
    
    var delegate: ContactDetailControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyView()
    }

    func applyView() {
        guard let contact = contact else { return }
        lblPhoneNumber.text = contact.phone
        lblEmail.text = contact.email
        lblStreet.text = contact.street
        lblCity.text = contact.city
        lblState.text = contact.state
        lblZipCode.text = contact.zip
        imgProfile.image = contact.image
        lblName.text = "\(contact.firstName) \(contact.lastName)"
        
        if contact.favorite {
            btnFavorite.setTitle("Remove From Favorites", for: .normal)
        } else {
            btnFavorite.setTitle("Mark as Favorite Contact", for: .normal)
        }
    }
    @IBAction func makeFavoriteClicked(_ sender: UIButton) {
        guard let contact = contact else { return }
        
        self.contact?.favorite = !contact.favorite
        
        if (self.contact?.favorite)! {
            btnFavorite.setTitle("Remove From Favorites", for: .normal)
        } else {
            btnFavorite.setTitle("Mark as Favorite Contact", for: .normal)
        }
        delegate?.markAsFavoriteContact(contact: self.contact!)
    }
}

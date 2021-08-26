//
//  ContactListViewController.swift
//  Contacts
//
//  Created by Burak İmdat on 26.08.2021.
//  Copyright © 2021 Furkan Sabaz. All rights reserved.
//

import UIKit

class ContactListViewController: UITableViewController {

    
//  var contacts: [Contact] = ContactSource.contacts
    
    var sectionContacts: [[Contact]] = ContactSource.sectionedContacts
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionContacts.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionContacts[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
//        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
//        let contact = contacts[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? contactCell else { fatalError("contact error") }
        
        let contact = sectionContacts[indexPath.section][indexPath.row]
        
        cell.lblName.text = "\(contact.firstName) \(contact.lastName)"
        cell.lblCity.text = contact.city
        cell.imgProfile.image = contact.image
        cell.imgFavorite.isHidden = !contact.favorite
    
//        cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
//        cell.imageView?.image = contact.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContactSource.uniqueFirstLetters[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ContactSource.uniqueFirstLetters
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedContact = sectionContacts[indexPath.section][indexPath.row]
                
                guard let navigationController = segue.destination as? UINavigationController, let contactDetailController = navigationController.topViewController as? ContactDetailViewController else { return }
                
                contactDetailController.contact = selectedContact
                contactDetailController.delegate = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension Contact: Equatable {
    static func == (lContact: Contact, rContact: Contact) -> Bool {
        return
            lContact.firstName == rContact.firstName &&
            lContact.lastName == rContact.lastName &&
            lContact.street == rContact.street &&
            lContact.city == rContact.city &&
            lContact.zip == rContact.zip &&
            lContact.phone == rContact.phone &&
            lContact.email == rContact.email
    }
}

extension ContactListViewController: ContactDetailControllerDelegate {
    func markAsFavoriteContact(contact: Contact) {
        var sectionIndex: Int? = nil
        var contactIndex: Int? = nil
        
        for (index, contacts) in sectionContacts.enumerated() {
            if let indexOfContacts = contacts.index(of: contact) {
                sectionIndex = index
                contactIndex = indexOfContacts
                break
            }
        }
        
        if let sectionIndex = sectionIndex, let contactIndex = contactIndex {
            sectionContacts[sectionIndex][contactIndex].favorite = contact.favorite
            tableView.reloadData()
        }
    }
}

extension Contact {
    var firstLetter: String {
        return String(firstName.prefix(1))
    }
}

extension ContactSource {
    static var uniqueFirstLetters: [String] {
        let firstLetters = contacts.map { $0.firstLetter }
        let uniqueFirstLetters = Set(firstLetters)
        return Array(uniqueFirstLetters.sorted())
    }
    
    static var sectionedContacts: [[Contact]] {
        return uniqueFirstLetters.map{ firstLetter in
            let filteredContacts = contacts.filter { $0.firstLetter == firstLetter }
            return filteredContacts.sorted(by: { $0.firstName < $1.firstName })
        }
    }
}

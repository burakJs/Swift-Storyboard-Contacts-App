//
//  pListLoader.swift
//  Contacts
//
//  Created by Burak İmdat on 26.08.2021.
//  Copyright © 2021 Furkan Sabaz. All rights reserved.
//

import Foundation

enum PListError: Error {
    case invalidResource // DOSYA BULUNAMADI
    case parsingFailure // DOSYA VAR AMA IMPORT EDILMIYOR
}

class PlistLoader {
    
    static func array(fileName: String, extension_: String) throws -> [[String: String]] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: extension_) else { throw PListError.invalidResource }
        
        guard let data = NSArray(contentsOfFile: path) as? [[String: String]] else { throw PListError.parsingFailure }
        
        return data
    }
    
}

class ContactSource {
    static var contacts: [Contact] {
        let data = try! PlistLoader.array(fileName: "ContactsDB", extension_: "plist")
        return data.compactMap { Contact(data: $0) }
    }
}

//
//  ContactsData.swift
//  (ammaraidzat)AppTest
//
//  Created by Ammar Aidzat on 23/03/2023.
//

import Foundation

class ContactsCell {
    private(set) var allContacts: [Contact] = []
    
    init() {
        parseContacts()
    }
    
    func parseContacts() {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        if let url = Bundle.main.url(forResource: "data", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let contacts = try? decoder.decode([Contact].self, from: data), contacts.count>0 {
            allContacts = contacts
        }
    }
    
    func updateContactDetails(for contact: Contact) {
        if let index = allContacts.firstIndex(where: { $0.id == contact.id }) {
            allContacts[index] = contact
        }
    }
    
}

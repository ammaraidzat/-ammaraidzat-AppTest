//
//  contactsViewModel.swift
//  (ammaraidzat)AppTest
//
//  Created by Ammar Aidzat on 23/03/2023.
//

import Foundation
import Combine

class ContactsViewModel {
    private var store: ContactsCell
    var contact: [Contact] { store.allContacts }
    @Published var reloadMainView: Void = ()
    
    init() {
        self.store = ContactsCell()
        reloadContactsFromJson()
    }
    
    func reloadContactsFromJson() {
        store.parseContacts()
        reloadMainView = ()
    }

    func saveEditedContact(_ contact: Contact) {
        store.updateContactDetails(for: contact)
        reloadMainView = ()
    }
    
    
    enum ContactDetailType: String {
        case firstName = "First Name"
        case lastName = "Last Name"
        case email = "Email"
        case dob = "DOB"
    }
    
}

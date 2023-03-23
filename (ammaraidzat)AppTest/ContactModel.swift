//
//  ContactModel.swift
//  (ammaraidzat)AppTest
//
//  Created by Ammar Aidzat on 23/03/2023.
//

import Foundation


struct Contact:Codable, Identifiable {
    let id: String
    var firstname: String
    var lastname: String
    var email: String?
    var dob: Date?
    
    
}

extension Contact: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(firstname)
        hasher.combine(lastname)
        hasher.combine(email)
        hasher.combine(dob)
    }
}

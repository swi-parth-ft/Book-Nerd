//
//  Student.swift
//  Book Nerd
//
//  Created by Parth Antala on 2024-07-12.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

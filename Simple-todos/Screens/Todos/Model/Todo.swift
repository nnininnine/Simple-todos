//
//  Todo.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import Foundation
import RealmSwift

typealias Todos = [Todo]

class Todo: Object {
    // MARK: Property

    @Persisted(primaryKey: true) var id: UUID?
    @Persisted var message: String = ""
    @Persisted var complete: Bool = false

    convenience init(id: UUID, message: String) {
        self.init()
        self.id = id
        self.message = message
        self.complete = false
    }

    func isComplete(_ isComplete: Bool) {
        complete = isComplete
    }
}

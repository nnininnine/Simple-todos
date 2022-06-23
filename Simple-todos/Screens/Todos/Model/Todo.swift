//
//  Todo.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import Foundation

typealias Todos = [Todo]

struct Todo: Codable {
    let id: UUID?
    let message: String
}

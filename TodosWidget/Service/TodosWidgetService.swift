//
//  TodosWidgetService.swift
//  TodosWidgetExtension
//
//  Created by 7Peaks on 22/7/2565 BE.
//

import Foundation
import RealmSwift

class TodosWidgetService {
  // MARK: - Properties

  static let shared: TodosWidgetService = .init()

  private var localRealm: Realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

  // MARK: - Init

  private init() {}

  // MARK: - Methods

  func getAllTodos() -> Todos {
    let result = localRealm.objects(Todo.self)
    return Array(result)
  }

  func isEmpty() -> Bool {
    return localRealm.isEmpty
  }

  func getRandTodo() -> Todo? {
    let todos = getAllTodos()
    let randIndex = Int.random(in: 0 ..< todos.count)

    return todos[randIndex]
  }
}

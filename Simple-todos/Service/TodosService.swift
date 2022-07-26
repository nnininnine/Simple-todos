//
//  TodosService.swift
//  Simple-todos
//
//  Created by 7Peaks on 25/7/2565 BE.
//

import Foundation
import RealmSwift
import WidgetKit

class TodosService {
  static let shared: TodosService = .init()

  // MARK: - Realm Instance

  private var realm: Realm = {
    let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.example")
    let realmURL = container?.appendingPathComponent("default.realm")
    let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
    return try! Realm(configuration: config)
  }()

  // MARK: - Init

  private init() {}

  // MARK: - Methods

  func getAllTodos() -> Todos {
    let result = realm.objects(Todo.self)

    refreshTodosWidget()
    return Array(result)
  }

  func isEmpty() -> Bool {
    return realm.isEmpty
  }

  func getRandTodo() -> Todo? {
    let todos = getAllTodos()
    if todos.isEmpty {
      return nil
    }
    let randIndex = Int.random(in: 0 ..< todos.count)

    return todos[randIndex]
  }

  func createTodo(message: String?, id: UUID? = nil) throws {
    do {
      try realm.write {
        realm.add(Todo(id: id != nil ? id! : UUID(), message: message ?? "Temp task"))
      }
    } catch let err {
      throw err
    }
  }

  func deleteTodo(todo: Todo) {
    guard let todo = realm.object(ofType: Todo.self, forPrimaryKey: todo.id) else { return }

    try! realm.write {
      realm.delete(todo)
    }
  }

  func updateComplete(todo: Todo) {
    // update
    guard let todo = realm.object(ofType: Todo.self, forPrimaryKey: todo.id) else { return }

    try! realm.write {
      todo.complete = !todo.complete
    }
  }

  func getTodo(by id: UUID) -> Todo? {
    return realm.object(ofType: Todo.self, forPrimaryKey: id)
  }

  func refreshTodosWidget() {
    WidgetCenter.shared.reloadTimelines(ofKind: "TodosWidget")
  }
}

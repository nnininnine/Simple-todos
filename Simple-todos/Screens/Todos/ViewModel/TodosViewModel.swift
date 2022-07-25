//
//  TodosViewModel.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import Foundation
import RealmSwift
import RxSwift

class TodosViewModel {
  // MARK: Property

  var todos: PublishSubject<Todos> = .init()
  let disposeBag: DisposeBag = .init()

  // MARK: Init

  init() {}
  // init with realm
  init(realm: Realm) {
//    localRealm = realm
  }

  // MARK: Methods

  func getTodos() {
    let todosData = TodosService.shared.getAllTodos()
    todos.onNext(Array(todosData))
  }

  func displayActionSheets(vc: UIViewController, todo: Todo) {
    let actionSheet = UIAlertController(title: "Manage Todo", message: nil, preferredStyle: .actionSheet)

    // add action
    actionSheet.addAction(UIAlertAction(
      title: todo.complete ? "Set as incomplete" : "Set as complete",
      style: .default,
      handler: { _ in self.updateComplete(todo: todo) }
    ))
    actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in self.deleteTodo(todo: todo) }))
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    vc.present(actionSheet, animated: true)
  }

  func deleteTodo(todo: Todo) {
    TodosService.shared.deleteTodo(todo: todo)

    getTodos()
  }

  func updateComplete(todo: Todo) {
    // update
    TodosService.shared.updateComplete(todo: todo)

    getTodos()
  }
}

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

    private var localRealm: Realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    var todos: PublishSubject<Todos> = .init()
    let disposeBag: DisposeBag = .init()

    // MARK: Init

    init() {}
    // init with realm
    init(realm: Realm) {
        localRealm = realm
    }

    // MARK: Methods

    func getTodos() {
        let todosData = localRealm.objects(Todo.self)
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
        guard let todo = localRealm.object(ofType: Todo.self, forPrimaryKey: todo.id) else { return }

        try! localRealm.write {
            localRealm.delete(todo)
        }

        getTodos()
    }

    func updateComplete(todo: Todo) {
        // update
        guard let todo = localRealm.object(ofType: Todo.self, forPrimaryKey: todo.id) else { return }

        try! localRealm.write {
            todo.complete = !todo.complete
        }

        getTodos()
    }
}

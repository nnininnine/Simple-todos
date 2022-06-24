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

    private let localRealm: Realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    var todos: PublishSubject<Todos> = .init()
    let disposeBag: DisposeBag = .init()

    // MARK: Init

    init() {}

    // MARK: Methods

    func getTodos() {
        let todosData = localRealm.objects(Todo.self)
        todos.onNext(Array(todosData))
    }
}

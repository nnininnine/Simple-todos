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

    private let localRealm: Realm = try! Realm()
    var todos: PublishSubject<Todos> = .init()
    let disposeBag: DisposeBag = .init()

    // MARK: Init

    init() {}

    // MARK: Methods

    func getTodos() {}
}

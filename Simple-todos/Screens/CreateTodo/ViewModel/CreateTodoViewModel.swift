//
//  CreateTodoViewModel.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import Foundation
import RealmSwift
import RxSwift
import UIKit

class CreateTodoViewModel {
    // MARK: Property

    private let localRealm: Realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    var todoValidator: Observable<Bool>?
    let disposeBag: DisposeBag = .init()

    // MARK: Init

    init() {}

    // MARK: Methods

    func createTodo(vc: UIViewController?, message: String?) {
        if let message = message, message.count > 0 {
            do {
                try localRealm.write {
                    localRealm.add(Todo(id: UUID(), message: message))
                }
                popToTodos(vc: vc)
            } catch let err {
                displayAlert(vc: vc, title: "Create failed.", message: err.localizedDescription)
            }
        } else {
            displayAlert(vc: vc, title: "Create failed.", message: "There's no message to create todo.")
        }
    }

    private func popToTodos(vc: UIViewController?) {
        vc?.navigationController?.popViewController(animated: true)
    }

    private func displayAlert(vc: UIViewController?, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: nil))

        vc?.present(alert, animated: true, completion: nil)
    }
}

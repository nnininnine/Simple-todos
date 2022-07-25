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

  var todoValidator: Observable<Bool>?
  let disposeBag: DisposeBag = .init()

  // MARK: Init

  init() {}
  // init with realm
  init(realm: Realm) {
//        localRealm = realm
  }

  // MARK: Methods

  func createTodo(vc: UIViewController?, message: String?, id: UUID? = nil) {
    if let message = message, message.count > 0 {
      do {
        try TodosService.shared.createTodo(message: message, id: id)

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

//
//  CreateTodoViewController.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class CreateTodoViewController: UIViewController {
    // MARK: Outlets

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var createButton: UIButton!

    // MARK: Property

    let disposeBag: DisposeBag = .init()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: Methods

    func setup() {
        // todo validation
        let todoValidator: Observable<Bool> = textField.rx.text.orEmpty.map { $0.count > 0 }
            .asObservable()

        // binding
        todoValidator.bind(to: createButton.rx.isEnabled).disposed(by: disposeBag)
    }
}

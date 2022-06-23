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

    lazy var viewModel: CreateTodoViewModel = .init()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: Methods

    func setup() {
        // todo validation
        viewModel.todoValidator = textField.rx.text.orEmpty.map { $0.count > 0 }
            .asObservable()

        // binding
        viewModel.todoValidator?.bind(to: createButton.rx.isEnabled).disposed(by: viewModel.disposeBag)

        // on event
        // on tap button
        createButton.rx.tap.asObservable().subscribe(onNext: { [weak self] in
            self?.viewModel.createTodo(vc: self, message: self?.textField.text)
        }).disposed(by: viewModel.disposeBag)

        // editingDidEndOnExit textfield
        textField.rx.controlEvent(.editingDidEndOnExit).asObservable().subscribe(onNext: { [weak self] in
            self?.viewModel.createTodo(vc: self, message: self?.textField.text)
        }).disposed(by: viewModel.disposeBag)
    }
}

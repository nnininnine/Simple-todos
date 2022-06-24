//
//  TodosViewController.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class TodosViewController: UIViewController {
    // MARK: Outlets

    @IBOutlet private var tableView: UITableView!

    // MARK: Property

    private lazy var viewModel: TodosViewModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupWillAppear()
    }

    // MARK: Methods

    func setup() {
        // setup add todo button
        guard let addButton = navigationItem.rightBarButtonItem else { return }
        addButton.target = self
        addButton.action = #selector(routeToCreateTodo)

        // setup tableView
        tableView.register(TodoCell.nib(), forCellReuseIdentifier: TodoCell.identifier)

        // binding data
        viewModel.todos.asObservable().bind(to: tableView.rx.items(cellIdentifier: TodoCell.identifier)) { (_, todo: Todo, cell: TodoCell) in
            cell.todo = todo
        }.disposed(by: viewModel.disposeBag)

        // on tap todo cell
        tableView.rx.modelSelected(Todo.self).subscribe(onNext: { [weak self] (todo: Todo) in
            guard let self = self else { return }
            self.viewModel.displayActionSheets(vc: self, todo: todo)
        }).disposed(by: viewModel.disposeBag)
    }

    func setupWillAppear() {
        viewModel.getTodos()
    }

    @objc func routeToCreateTodo() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateTodoViewController")
        show(vc, sender: nil)
    }
}

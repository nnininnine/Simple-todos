//
//  TodosViewController.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import Foundation
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

        // binding data
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

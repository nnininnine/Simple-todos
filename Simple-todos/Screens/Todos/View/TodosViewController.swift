//
//  TodosViewController.swift
//  Simple-todos
//
//  Created by 7Peaks on 23/6/2565 BE.
//

import Foundation
import UIKit

class TodosViewController: UIViewController {
    // MARK: Property

    private var viewModel: TodosViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        // setup add todo button
        guard let addButton = navigationItem.rightBarButtonItem else { return }
        addButton.target = self
        addButton.action = #selector(routeToCreateTodo)
    }

    @objc func routeToCreateTodo() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateTodoViewController")
        show(vc, sender: nil)
    }
}

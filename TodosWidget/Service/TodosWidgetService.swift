//
//  TodosWidgetService.swift
//  TodosWidgetExtension
//
//  Created by 7Peaks on 22/7/2565 BE.
//

import Foundation

class TodosWidgetService {
  // MARK: - Properties

  static let shared: TodosWidgetService = .init()

  // MARK: - Init

  private init() {}

  // MARK: - Methods

  func getAllTodos() -> Todos {
    return []
  }
}

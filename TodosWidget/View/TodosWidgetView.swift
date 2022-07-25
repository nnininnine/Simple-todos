//
//  TodoWidgetView.swift
//  Simple-todos
//
//  Created by 7Peaks on 22/7/2565 BE.
//

import RealmSwift
import SwiftUI
import WidgetKit

struct TodosWidgetView: View {
  // MARK: - Properties

  @Environment(\.widgetFamily) var family: WidgetFamily
  var todos: Todos = []

  // MARK: - Init

  init(todos: Todos) {
    self.todos = todos
  }

  // MARK: - Body

  @ViewBuilder
  var body: some View {
    if family == .systemLarge {
      TodosWidgetLargeView(todos: todos)
    } else {
      TodosWidgetSmallMediumView(todos: todos)
    }
  }
}

struct TodoWidgetView_Previews: PreviewProvider {
  static let mockData: Todos = [
    Todo(id: UUID(), message: "Task 1"),
    Todo(id: UUID(), message: "Task 2"),
    Todo(id: UUID(), message: "Task 3"),
    Todo(id: UUID(), message: "Task 4"),
    Todo(id: UUID(), message: "Task 5")
  ]

  static var previews: some View {
    TodosWidgetView(todos: mockData)
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}

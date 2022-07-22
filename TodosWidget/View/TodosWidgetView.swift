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

  var todos: Todos = []
  var todosCount: Int = 0

  // MARK: - Init

  init(todos: Todos) {
    self.todosCount = todos.count

    if todosCount > 3 {
      self.todos = Array(todos[0 ..< 3])
    } else {
      self.todos = todos
    }
  }

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      HStack {
        Text("Task")
          .bold()
        Spacer()
        Text("\(todosCount)")
          .font(.system(size: 14))
          .bold()
          .frame(width: 20, height: 20)
          .background(Circle().fill(.gray))
      }
      ForEach(todos, id: \.id) { todo in
        HStack(spacing: 2) {
          Circle()
            .strokeBorder(.gray, lineWidth: 1)
            .frame(width: 16, height: 16)
          Text(todo.message)
            .padding(4)
        }
      }
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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

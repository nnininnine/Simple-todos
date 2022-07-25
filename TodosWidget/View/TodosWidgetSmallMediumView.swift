//
//  TodosWidgetSmallMediumView.swift
//  TodosWidgetExtension
//
//  Created by 7Peaks on 25/7/2565 BE.
//

import SwiftUI
import WidgetKit

struct TodosWidgetSmallMediumView: View {
  // MARK: - Properties

  @Environment(\.widgetFamily) var family: WidgetFamily
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
            .lineLimit(1)
            .padding(4)
        }
      }
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
  }
}

struct TodosWidgetSmallMediumView_Previews: PreviewProvider {
  static var previews: some View {
    TodosWidgetSmallMediumView(todos: [])
  }
}

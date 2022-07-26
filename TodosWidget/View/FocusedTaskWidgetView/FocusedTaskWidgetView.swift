//
//  FocusedTaskWidgetView.swift
//  TodosWidgetExtension
//
//  Created by 7Peaks on 26/7/2565 BE.
//

import SwiftUI
import WidgetKit

struct FocusedTaskWidgetView: View {
  // MARK: - Properties

  let todo: Todo

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading) {
      Text("Task:")
        .bold()
      Text(todo.message)
        .strikethrough(todo.complete, color: Color(uiColor: .label))
      Spacer()
      ZStack {
        Capsule()
          .fill(.pink)
          .frame(height: 42)
        Text("set as Complete")
          .bold()
          .font(.system(size: 14))
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .padding()
  }
}

struct FocusedTaskWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    FocusedTaskWidgetView(todo: TodosService.shared.getRandTodo() ?? Todo(id: UUID(), message: "Temp todo task. <3"))
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}

//
//  TodoWidgetView.swift
//  Simple-todos
//
//  Created by 7Peaks on 22/7/2565 BE.
//

import RealmSwift
import SwiftUI
import WidgetKit

struct TodoWidgetView: View {
  // MARK: - Properties

  var todos: Todos = []

  // MARK: - Body

  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct TodoWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    TodoWidgetView()
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}

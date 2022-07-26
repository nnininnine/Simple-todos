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

  var todo: Todo? = nil

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading) {
      Text("Task:")
        .bold()
      Text(todo?.message ?? "No task selected.")
        .strikethrough(todo?.complete ?? false, color: Color(uiColor: .label))
      Spacer()
      ZStack {
        Capsule()
          .fill(.pink)
          .frame(height: 42)
        Text(todo?.complete ?? false ? "set as Incomplete" : "set as Complete")
          .bold()
          .font(.system(size: 14))
      }
      .opacity(todo != nil ? 1 : 0)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .padding()
  }
}

struct FocusedTaskWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    FocusedTaskWidgetView()
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}

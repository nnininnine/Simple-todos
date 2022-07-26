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

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading) {
      Text("Task:")
        .bold()
      Text("Task The quick brown fox jumps over a lazy dog.")
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
    FocusedTaskWidgetView()
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}

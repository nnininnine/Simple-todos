//
//  FocusedTaskWidget.swift
//  TodosWidgetExtension
//
//  Created by 7Peaks on 25/7/2565 BE.
//

import SwiftUI
import WidgetKit

struct FocusedTaskProvider: TimelineProvider {
  let mockData: Todo = .init(id: UUID(), message: "Task 1")

  func placeholder(in context: Context) -> FocusedTaskEntry {
    FocusedTaskEntry(date: Date(), todo: mockData)
  }

  func getSnapshot(in context: Context, completion: @escaping (FocusedTaskEntry) -> ()) {
    let entry = FocusedTaskEntry(date: Date(), todo: mockData)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [FocusedTaskEntry] = []

    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = FocusedTaskEntry(date: entryDate, todo: TodosService.shared.getRandTodo())
      entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct FocusedTaskEntry: TimelineEntry {
  let date: Date
  let todo: Todo?
}

struct FocusedTaskWidgetEntryView: View {
  var entry: FocusedTaskProvider.Entry

  var body: some View {
//    TodosWidgetView(todos: entry.todos)
    Text("Task")
  }
}

struct FocusedTaskWidget: Widget {
  let kind: String = "FocusedTaskWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: FocusedTaskProvider()) { entry in
      FocusedTaskWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Focused Task")
    .description("Select the task for display in home.")
  }
}

struct FocusedTaskWidget_Previews: PreviewProvider {
  static var previews: some View {
    FocusedTaskWidgetEntryView(entry: FocusedTaskEntry(date: Date(), todo: nil))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}

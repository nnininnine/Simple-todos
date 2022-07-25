//
//  TodosWidget.swift
//  TodosWidget
//
//  Created by 7Peaks on 22/7/2565 BE.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
  let mockData: Todos = [
    Todo(id: UUID(), message: "Task 1"),
    Todo(id: UUID(), message: "Task 2"),
    Todo(id: UUID(), message: "Task 3"),
    Todo(id: UUID(), message: "Task 4"),
    Todo(id: UUID(), message: "Task 5")
  ]

  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), todos: mockData)
  }

  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), todos: mockData)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []

    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, todos: TodosService.shared.getAllTodos())
      entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let todos: Todos
}

struct TodosWidgetEntryView: View {
  var entry: Provider.Entry

  var body: some View {
    TodosWidgetView(todos: entry.todos)
  }
}

@main
struct TodosWidget: Widget {
  let kind: String = "TodosWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      TodosWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Tasks")
    .description("List of tasks.")
  }
}

struct TodosWidget_Previews: PreviewProvider {
  static var previews: some View {
    TodosWidgetEntryView(entry: SimpleEntry(date: Date(), todos: []))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}

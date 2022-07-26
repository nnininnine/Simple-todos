//
//  FocusedTaskWidget.swift
//  TodosWidgetExtension
//
//  Created by 7Peaks on 25/7/2565 BE.
//

import SwiftUI
import WidgetKit

struct FocusedTaskProvider: IntentTimelineProvider {
  typealias Entry = FocusedTaskEntry

  typealias Intent = SelectTaskIntent

  let mockData: Todo = .init(id: UUID(), message: "Task 1")

  func placeholder(in context: Context) -> FocusedTaskEntry {
    FocusedTaskEntry(date: Date(), todo: mockData)
  }

  func getSnapshot(for configuration: SelectTaskIntent, in context: Context, completion: @escaping (FocusedTaskEntry) -> Void) {
    let entry = FocusedTaskEntry(date: Date(), todo: mockData)

    completion(entry)
  }

  func getTimeline(for configuration: SelectTaskIntent, in context: Context, completion: @escaping (Timeline<FocusedTaskEntry>) -> Void) {
    var entries: [FocusedTaskEntry] = .init()

    let date: Date = .init()

    let entry: FocusedTaskEntry = .init(date: date, todo: getTodoFromConfig(configuration))

    entries.append(entry)

    let timeline = Timeline(entries: entries, policy: .never)
    completion(timeline)
  }

  func getTodoFromConfig(_ config: SelectTaskIntent) -> Todo? {
    guard let todoId = config.task?.identifier else { return nil }
    guard let todoUUID = UUID(uuidString: todoId) else { return nil }

    return TodosService.shared.getTodo(by: todoUUID)
  }
}

struct FocusedTaskEntry: TimelineEntry {
  let date: Date
  let todo: Todo?
}

struct FocusedTaskWidgetEntryView: View {
  var entry: FocusedTaskProvider.Entry

  var body: some View {
    FocusedTaskWidgetView(todo: entry.todo)
  }
}

struct FocusedTaskWidget: Widget {
  let kind: String = "FocusedTaskWidget"

  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: SelectTaskIntent.self, provider: FocusedTaskProvider()) { entry in
      FocusedTaskWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Focused Task")
    .description("Select the task for display in home screen.")
  }
}

struct FocusedTaskWidget_Previews: PreviewProvider {
  static var previews: some View {
    FocusedTaskWidgetEntryView(entry: FocusedTaskEntry(date: Date(), todo: nil))
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}

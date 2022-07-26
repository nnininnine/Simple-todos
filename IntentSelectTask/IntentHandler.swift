//
//  IntentHandler.swift
//  IntentSelectTask
//
//  Created by 7Peaks on 26/7/2565 BE.
//

import Intents

class IntentHandler: INExtension {
  override func handler(for intent: INIntent) -> Any {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.

    return self
  }
}

// MARK: - SelectTaskIntentHandling

extension IntentHandler: SelectTaskIntentHandling {
  func provideTaskOptionsCollection(for intent: SelectTaskIntent, with completion: @escaping (INObjectCollection<TaskINO>?, Error?) -> Void) {
    let tasks: [TaskINO] = TodosService.shared.getAllTodos().map { TaskINO(identifier: $0.id?.uuidString, display: "\($0.message)") }

    completion(INObjectCollection(items: tasks), nil)
  }
}

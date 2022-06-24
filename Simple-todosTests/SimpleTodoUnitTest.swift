//
//  SimpleTodoUnitTest.swift
//  Simple-todosTests
//
//  Created by Nuttapon Buaban on 24/6/2565 BE.
//

import Nimble
import Quick
import RealmSwift
@testable import Simple_todos
import XCTest

class SimpleTodoUnitTest: QuickSpec {
    var createViewModel: CreateTodoViewModel!
    var todosViewModel: TodosViewModel!
    var localRealm: Realm!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func spec() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        describe("Create todo") {
            localRealm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: self.name, deleteRealmIfMigrationNeeded: true))
            self.createViewModel = .init(realm: localRealm)
            context("with string") {
                let message = "test create task"
                self.createViewModel.createTodo(vc: nil, message: message)
                it("should contain this todo in context") {
                    let isContain = Array(self.localRealm.objects(Todo.self)).contains(where: { $0.message == message })
                    expect(isContain).toEventually(equal(true))
                }
            }
            context("with empty string") {
                let message = ""
                self.createViewModel.createTodo(vc: nil, message: message)
                it("should contain this todo in context") {
                    let isContain = Array(self.localRealm.objects(Todo.self)).contains(where: { $0.message == message })
                    expect(isContain).toEventually(equal(false))
                }
            }
        }
    }
}

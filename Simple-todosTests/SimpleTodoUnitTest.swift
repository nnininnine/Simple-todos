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
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        print("name: \(self.name)")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func spec() {
        describe("Create todo") {
            context("with string") {
                localRealm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
                let message: String = "test create task"
                self.createViewModel = .init()
                self.createViewModel.createTodo(vc: nil, message: message)
                it("should contain this todo in context") {
                    let isContain = Array(self.localRealm.objects(Todo.self)).contains(where: { $0.message == message })
                    expect(isContain).toEventually(equal(true))
                }
            }
            context("with empty string") {
                localRealm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
                let message: String = ""
                self.createViewModel = .init()
                self.createViewModel.createTodo(vc: nil, message: message)
                it("should contain this todo in context") {
                    let isContain = Array(self.localRealm.objects(Todo.self)).contains(where: { $0.message == message })
                    expect(isContain).toEventually(equal(false))
                }
            }
        }
    }
}

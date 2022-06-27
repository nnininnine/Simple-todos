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
    let todo = Todo(id: UUID(), message: "Todo for test.")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func spec() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        self.localRealm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: self.name, deleteRealmIfMigrationNeeded: true))
        // create todo
        describe("Create todo") {
            self.createViewModel = .init(realm: localRealm)
            context("with todo obj") {
                self.createViewModel.createTodo(vc: nil, message: self.todo.message, id: self.todo.id)
                it("should contain this todo in context") {
                    let isContain = Array(self.localRealm.objects(Todo.self)).contains(where: { $0.message == self.todo.message })
                    expect(isContain).toEventually(equal(true))
                }
            }
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
        // define todo object
        describe("define todo object") {
            context("with normal object") {
                let todo: Todo = .init(id: UUID(), message: "test todo list obj.")
                it("should be right data for each field") {
                    expect(todo.message).to(equal("test todo list obj."))
                    expect(todo.complete).to(equal(false))
                }
            }
        }
        // action to todo
        describe("Action to todo") {
            self.todosViewModel = .init(realm: self.localRealm)
            context("by update complete") {
                let todo = self.localRealm.object(ofType: Todo.self, forPrimaryKey: self.todo.id)
                it("should be false before call update") {
                    expect(todo).toNot(beNil())
                    expect(todo!.complete).to(equal(false))
                }
                it("should be true after call update") {
                    self.todosViewModel.updateComplete(todo: todo!)
                    expect(todo).toNot(beNil())
                    expect(todo!.complete).to(equal(true))
                }
            }

            context("by delete todo") {
                let message = "for delete"
                let id = UUID()
                self.createViewModel.createTodo(vc: nil, message: message, id: id)
                it("should be nil") {
                    let todo = self.localRealm.object(ofType: Todo.self, forPrimaryKey: id)
                    self.todosViewModel.deleteTodo(todo: todo!)

                    expect(self.localRealm.object(ofType: Todo.self, forPrimaryKey: id)).to(beNil())
                }
            }
        }
    }
}

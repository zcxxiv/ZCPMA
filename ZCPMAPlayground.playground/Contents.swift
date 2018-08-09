//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

struct NotificationDescriptor<A> {
  let name: Notification.Name
  let convert: (Notification) -> A
}

struct CustomNotificationDescriptor<A> {
  let name: Notification.Name
}

extension NotificationCenter {
  func addObserver<A>(
    descriptor: NotificationDescriptor<A>,
    using block: @escaping (A) -> ()) -> Token {
    let token = addObserver(
      forName: descriptor.name,
      object: nil,
      queue: nil,
      using: { note in block(descriptor.convert(note)) })
    return Token(token: token, center: self)
  }
  func addObserver<A>(
    descriptor: CustomNotificationDescriptor<A>,
    queue: OperationQueue,
    using block: @escaping (A) -> ()
    ) -> Token {
    let token  = addObserver(
      forName: descriptor.name,
      object: nil,
      queue: queue,
      using: { note in block(note.object as! A) })
    return Token(token: token, center: self)
  }
  func post<A>(descriptor: CustomNotificationDescriptor<A>, value: A) {
    post(name: descriptor.name, object: value)
  }
}

class Token {
  let token: NSObjectProtocol
  let center: NotificationCenter
  init(token: NSObjectProtocol, center: NotificationCenter) {
    self.token = token
    self.center = center
  }
  deinit {
    center.removeObserver(token)
  }
}

struct PlaygroundPagePayload {
  let page: PlaygroundPage
  let needsIndefiniteExecution: Bool
}

extension PlaygroundPagePayload {
  init(note: Notification) {
    page = note.object as! PlaygroundPage
    needsIndefiniteExecution = note.userInfo?["PlaygroundNeedsIndefiniteExecution"] as! Bool
  }
}

let playgroundNotification = NotificationDescriptor<PlaygroundPagePayload>(
  name: Notification.Name("PlaygroundPageNeedsIndefiniteExecutionDidChangeNotification"),
  convert: PlaygroundPagePayload.init
)

NotificationCenter.default.addObserver(descriptor: playgroundNotification, using: { print($0) })


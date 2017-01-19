import Foundation

public struct Vertex<T>: Equatable where T: Equatable, T: Hashable {
  public var data: T
  public let index: Int
}

extension Vertex {
  public static func ==(lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
    return lhs.data == rhs.data &&
           lhs.index == rhs.index
  }
}

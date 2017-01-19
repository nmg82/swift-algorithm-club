import Foundation

public struct Edge<T>: Equatable where T: Equatable, T: Hashable {
  public let from: Vertex<T>
  public let to: Vertex<T>
  
  public let weight: Double?
}

extension Edge {
  public static func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
    return lhs.from == rhs.from &&
           lhs.to == rhs.to &&
           lhs.weight == rhs.weight
  }
}

extension Edge: Hashable {
  public var hashValue: Int {
    return "\(from)\(to)\(weight)".hashValue
  }
}

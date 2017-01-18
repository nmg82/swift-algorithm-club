import Foundation

public struct Vertex<T: Hashable> {
  var data: T
}

extension Vertex: Hashable {
  public var hashValue: Int {
    //why not this??? return data.hashValue
    return "\(data)".hashValue
  }
  
  public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
    return lhs.data == rhs.data
  }
}

extension Vertex: CustomStringConvertible {
  public var description: String {
    return "\(data)"
  }
}

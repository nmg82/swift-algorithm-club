//The nodes in this binary tree don't have a reference to their parent node. It's not a major impediment but it will make certain operations slightly more cumbersome to implement.

public enum BST<T: Comparable> {
  case empty
  case leaf(T)
  indirect case node(BST, T, BST)
}

extension BST {
  public var count: Int {
    switch self {
      case .empty: return 0
      case .leaf: return 1
      case let .node(left, _, right): return left.count + 1 + right.count
    }
  }
  
  public var height: Int {
    switch self {
      case .empty: return 0
      case .leaf: return 1
      case let .node(left, _, right): return 1 + max(left.height, right.height)
    }
  }
}

extension BST {
  public func insert(_ newValue: T) -> BST {
    switch self {
    case .empty: return .leaf(newValue)
    
    case let .leaf(value):
      if newValue < value {
        return .node(.leaf(newValue), value, .empty)
      } else {
        return .node(.empty, value, .leaf(newValue))
      }
      
    case let .node(left, value, right):
      if newValue < value {
        return .node(left.insert(newValue), value, right)
      } else {
        return .node(left, value, right.insert(newValue))
      }
    }
  }
}

extension BST {
  public func search(_ searchValue: T) -> BST? {
    switch self {
    case .empty: return nil
    case let .leaf(value): return (searchValue == value) ? self : nil
    case let .node(left, value, right):
      if searchValue < value { return left.search(searchValue) }
      else if searchValue > value { return right.search(searchValue) }
      else { return self }
    }
  }
}

extension BST: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
      case .empty: return "."
      case let .leaf(value): return "\(value)"
      case let .node(left, value, right): return "(\(left.debugDescription) <- \(value) -> \(right.debugDescription))"
    }
  }
}

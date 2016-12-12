//A binary tree is a tree where each node has 0, 1, or 2 children. The important bit is that 2 is the max – that’s why it’s binary.

//A binary search tree is a special kind of binary tree (a tree in which each node has at most two children) that performs insertions and deletions such that the tree is always sorted.

enum BinaryTree<T: Comparable> {
  case empty
  indirect case node(BinaryTree, T, BinaryTree)
}

extension BinaryTree {
  var count: Int {
    switch self {
    case .empty: return 0
    case let .node(left, _, right):
      return left.count + 1 + right.count
    }
  }
}

extension BinaryTree {
  
  //doesn't work due to copy-on-write
  //Using classes (reference semantics) won't have the copy-on-write behaviour, so you'll be able to insert without making a complete copy of the tree.
  mutating func naiveInsert(_ newValue: T) {
    guard case .node(var left, let value, var right) = self else {
      self = .node(.empty, newValue, .empty)
      return
    }
    
    if newValue < value { left.naiveInsert(newValue) }
    else if newValue > value { right.naiveInsert(newValue) }
  }
  
  mutating func insert(_ newValue: T) {
    self = newTreeWithInsertedValue(newValue)
  }
  
  private func newTreeWithInsertedValue(_ newValue: T) -> BinaryTree {
    switch self {
    case .empty:
      return .node(.empty, newValue, .empty)
    case let .node(left, value, right):
      if newValue < value {
        return .node(left.newTreeWithInsertedValue(newValue), value, right)
      } else {
        return .node(left, value, right.newTreeWithInsertedValue(newValue))
      }
    }
  }
}

extension BinaryTree {
  //In-order traversal of a binary search tree is to go through the nodes in ascending order.
  //Starting from the top, you head to the left as much as you can. If you can't go left anymore, you'll visit the current node and attempt to traverse to the right side. This procedure continues until you traverse through all the nodes.
  func traverseInOrder(process: (T) -> ()) {
    switch self {
    case .empty: return
    case let .node(left, value, right):
      left.traverseInOrder(process: process)
      process(value)
      right.traverseInOrder(process: process)
    }
  }
  
  //Pre-order traversal of a binary search tree is to go through the nodes whilst visiting the current node first. The key here is calling process before traversing through the children.
  func traversePreOrder(process: (T) -> ()) {
    switch self {
    case .empty: return
    case let .node(left, value, right):
      process(value)
      left.traverseInOrder(process: process)
      right.traverseInOrder(process: process)
    }
  }
  
  //Post-order traversal of a binary search tree is to visit the nodes only after traversing through it's left and right children.
  func traversePostOrder(process: (T) -> ()) {
    switch self {
    case .empty: return
    case let .node(left, value, right):
      left.traverseInOrder(process: process)
      right.traverseInOrder(process: process)
      process(value)
    }
  }
}

extension BinaryTree {
  //Unlike the traversal algorithms, the search algorithm will traverse only 1 side at every recursive step. On average, this leads to a time complexity of O(log n), which is considerably faster than the O(n) traversal.
  func search(_ searchValue: T) -> BinaryTree? {
    switch self {
    case .empty: return nil
    case let .node(left, value, right):
      if searchValue == value { return self }
      
      if searchValue < value {
        return left.search(searchValue)
      } else {
        return right.search(searchValue)
      }
    }
  }
}

extension BinaryTree: CustomStringConvertible {
  var description: String {
    switch self {
    case .empty: return ""
    case let .node(left, value, right):
      return "value: \(value), left = [\(left.description)], right = [\(right.description)]"
    }
  }
}

//// leaf nodes
//let node5 = BinaryTree.node(.empty, "5", .empty)
//let nodeA = BinaryTree.node(.empty, "a", .empty)
//let node10 = BinaryTree.node(.empty, "10", .empty)
//let node4 = BinaryTree.node(.empty, "4", .empty)
//let node3 = BinaryTree.node(.empty, "3", .empty)
//let nodeB = BinaryTree.node(.empty, "b", .empty)
//
//// intermediate nodes on the left
//let Aminus10 = BinaryTree.node(nodeA, "-", node10)
//let timesLeft = BinaryTree.node(node5, "*", Aminus10)
//
//// intermediate nodes on the right
//let minus4 = BinaryTree.node(.empty, "-", node4)
//let divide3andB = BinaryTree.node(node3, "/", nodeB)
//let timesRight = BinaryTree.node(minus4, "*", divide3andB)
//
//// root node
//let tree = BinaryTree.node(timesLeft, "+", timesRight)
//
////print(tree)
////dump(tree)
//tree.count
//
//var binaryTree: BinaryTree<Int> = .empty
//binaryTree.insert(5)
//binaryTree.insert(7)
//binaryTree.insert(9)
//print(binaryTree)

//traversal
var tree: BinaryTree<Int> = .empty
tree.insert(7)
tree.insert(10)
tree.insert(2)
tree.insert(1)
tree.insert(5)
tree.insert(9)

//tree.traverseInOrder { print($0) }
//tree.traversePreOrder { print($0) }
//tree.traversePostOrder { print($0) }

tree.search(5)



public class BinarySearchTree<T: Comparable> {
  private(set) public var value: T
  fileprivate(set) public var parent: BinarySearchTree?
  fileprivate(set) public var left: BinarySearchTree?
  fileprivate(set) public var right: BinarySearchTree?
  
  public init(value: T) {
    self.value = value
  }
  
  public convenience init(array: [T]) {
    precondition(array.count > 0)
    self.init(value: array.first!)
    for v in array.dropFirst() {
      insert(v, parent: self)
    }
  }
  
  public var isRoot: Bool {
    return parent == nil
  }
  
  public var isLeaf: Bool {
    return left == nil && right == nil
  }
  
  public var isLeftChild: Bool {
    return parent?.left === self
  }
  
  public var isRightChild: Bool {
    return parent?.right === self
  }
  
  public var hasLeftChild: Bool {
    return left != nil
  }
  
  public var hasRightChild: Bool {
    return right != nil
  }
  
  public var hasAnyChild: Bool {
    return hasLeftChild || hasRightChild
  }
  
  public var hasBothChildren: Bool {
    return hasLeftChild && hasRightChild
  }
  
  public var count: Int {
    let leftCount = left?.count ?? 0
    let rightCount = right?.count ?? 0
    return leftCount + 1 + rightCount
  }
}

extension BinarySearchTree {
  
  // O(n) performance
  public func height() -> Int {
    if isLeaf {
      return 0
    }
    
    else {
      let leftHeight = left?.height() ?? 0
      let rightHeight = right?.height() ?? 0
      
      return 1 + max(leftHeight, rightHeight)
    }
  }
  
  
  // It steps upwards through the tree, following the parent pointers until we reach the root node (whose parent is nil). 
  // This takes O(h) time.
  public func depth() -> Int {
    var node = self
    var edges = 0
    
    while case let parent? = node.parent {
      node = parent
      edges += 1
    }
    
    return edges
  }
}

extension BinarySearchTree {
  //Because the whole point of a binary search tree is to have smaller nodes on the left and larger ones on the right, you should always insert elements at the root, to make to sure this remains a valid binary tree!
  public func insert(_ value: T) {
    insert(value, parent: self)
  }
  
  fileprivate func insert(_ value: T, parent: BinarySearchTree) {
    if value < self.value {
      if let left = left {
        left.insert(value, parent: left)
      } else {
        left = BinarySearchTree(value: value)
        left?.parent = parent
      }
    } else {
      if let right = right {
        right.insert(value, parent: right)
      } else {
        right = BinarySearchTree(value: value)
        right?.parent = parent
      }
    }
  }
}

extension BinarySearchTree {
  // If there are duplicate items in the tree, search() always returns the "highest" node. That makes sense, because we start searching from the root downwards.
  public func search(_ value: T) -> BinarySearchTree? {
    if value < self.value {
      return left?.search(value)
    }
      
    else if value > self.value {
      return right?.search(value)
    }
      
    else { return self } // found it!
  }
  
  public func searchUsingLoop(_ value: T) -> BinarySearchTree? {
    var node: BinarySearchTree? = self
    
    while case let n? = node { //this also seems to work: while let n = node
      if value < n.value {
        node = n.left
      }
        
      else if value > n.value {
        node = n.right
      }
        
      else { return node }
    }
    
    return nil
  }
}

extension BinarySearchTree {
  public func traverseInOrder(_ process: (T) -> ()) {
    left?.traverseInOrder(process)
    process(value)
    right?.traverseInOrder(process)
  }
  
  public func traversePreOrder(_ process: (T) -> ()) {
    process(value)
    left?.traversePreOrder(process)
    right?.traversePreOrder(process)
  }
  
  public func traversePostOrder(_ process: (T) -> ()) {
    left?.traversePostOrder(process)
    right?.traversePostOrder(process)
    process(value)
  }
}

extension BinarySearchTree {
  public func toArray() -> [T] {
    return map { $0 }
  }
  
  public func map(_ formula: (T) -> T) -> [T] {
    var a = [T]()
    
    if let left = left {
      a += left.map(formula)
    }
    
    a.append(formula(value))
    
    if let right = right {
      a += right.map(formula)
    }
    
    return a
  }
  
  //TODO: implement filter & reduce
}

extension BinarySearchTree {
  
  // like most binary search tree operations, removing a node runs in O(h) time, where h is the height of the tree
  public func remove() -> BinarySearchTree? {
    let replacement: BinarySearchTree?
    
    if let left = left {
      if let right = right {
        replacement = removeNodeWithTwoChildren(left, right) // this node has two children
      } else {
        replacement = left // This node only has a left child. The left child replaces the node.
      }
    }
      
    else if let right = right { // This node only has a right child. The right child replaces the node.
      replacement = right
    }
      
    else {
      replacement = nil // This node has no children. We just disconnect it from its parent.
    }
    
    reconnectParentToNode(replacement)
    
    parent = nil
    left = nil
    right = nil
    
    return replacement
  }
  
  // If the node to remove has two children, it must be replaced by the smallest child that is larger than this node's value.
  // That always happens to be the leftmost descendent of the right child, i.e. right.minimum().
  // We take that node out of its original position in the tree and put it into the place of the node we're removing.
  private func removeNodeWithTwoChildren(_ left: BinarySearchTree, _ right: BinarySearchTree) -> BinarySearchTree {
    let successor = right.minimum()
    let _ = successor.remove()
    
    successor.left = left
    left.parent = successor
    
    if right !== successor {
      successor.right = right
      right.parent = successor
    } else {
      successor.right = nil
    }
    
    return successor
  }
  
  private func reconnectParentToNode(_ node: BinarySearchTree?) {
    if let parent = parent {
      if isLeftChild {
        parent.left = node
      } else {
        parent.right = node
      }
    }
    
    node?.parent = parent
  }
  
  public func minimum() -> BinarySearchTree {
    var node = self
    while case let next? = node.left {
      node = next
    }
    return node
  }
  
  public func maximum() -> BinarySearchTree {
    var node = self
    while case let next? = node.right {
      node = next
    }
    return node
  }
}

extension BinarySearchTree {
  // O(h) performance
  public func predecessor() -> BinarySearchTree<T>? {
    if let left = left {
      return left.maximum()
    }
    
    else {
      var node = self
      while case let parent? = node.parent {
        if parent.value < value { return parent }
        node = parent
      }
      return nil
    }
  }
  
  // O(h) performance
  public func successor() -> BinarySearchTree<T>? {
    if let right = right {
      return right.minimum()
    }
    
    else {
      var node = self
      while case let parent? = node.parent {
        if parent.value > value { return parent }
        node = parent
      }
      return nil
    }
  }
}

extension BinarySearchTree {
  public func isBST(minValue: T, maxValue: T) -> Bool {
    if value < minValue || value > maxValue { return false }
    
    let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
    let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
    
    return leftBST && rightBST
  }
}

extension BinarySearchTree: CustomStringConvertible {
  public var description: String {
    var s = ""
    
    if let left = left {
      s += "(\(left.description)) <- "
    }
    
    s += "\(value)"
    
    if let right = right {
      s += " -> (\(right.description))"
    }
    
    return s
  }
}

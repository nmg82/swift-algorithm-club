public class LinkedListNode<T> {
  var value: T
  var next: LinkedListNode?
  weak var previous: LinkedListNode?
  
  public init(value: T) {
    self.value = value
  }
}

public class LinkedList<T> {
  public typealias Node = LinkedListNode<T>
  
  private var head: Node?
  
  public var isEmpty: Bool {
    return head == nil
  }
  
  public var first: Node? {
    return head
  }
  
  public var last: Node? {
    guard var node = head else { return nil }
    
    while case let next? = node.next {
      node = next
    }
    
    return node
  }

  
  // Note: One way to speed up count from O(n) to O(1) is to keep track of a variable that
  // counts how many nodes are in the list. Whenever you add or remove a node, you also update this variable.
  public var count: Int {
    guard var node = head else { return 0 }
    
    var c = 1
    
    while case let next? = node.next {
      node = next
      c += 1
    }
    
    return c
  }
  
  public func append(_ value: T) {
    let newNode = Node(value: value)
    guard let lastNode = last else {
      head = newNode
      return
    }
    
    newNode.previous = lastNode
    lastNode.next = newNode
  }
  
  public func nodeAt(_ index: Int) -> Node? {
    if index >= 0 {
      var node = head
      var i = index
      while node != nil {
        if i == 0 { return node }
        i -= 1
        node = node!.next
      }
    }
    return nil
  }
  
  public subscript(index: Int) -> T {
    //not a huge fan of this implementation
    //this is returning the value of the node at the index
    //whereas the nodeAt function is returning the actual node, and it's optional
    let node = nodeAt(index)
    assert(node != nil) //also this doesn't fail very gracefully IMO
    return node!.value
  }
  
  public func insert(value: T, atIndex index: Int) {
    let (prev, next) = nodesBeforeAndAfter(index: index)
    
    let newNode = Node(value: value)
    newNode.previous = prev
    newNode.next = next
    prev?.next = newNode
    next?.previous = newNode
    
    if prev == nil {
      head = newNode
    }
  }
  
  private func nodesBeforeAndAfter(index: Int) -> (Node?, Node?) {
    assert(index >= 0)
    
    var i = index
    var next = head
    var prev: Node?
    
    while next != nil && i > 0 {
      i -= 1
      prev = next
      next = next!.next
    }
    
    assert(i == 0)
    
    return (prev, next)
  }
  
  public func removeAll() {
    head = nil
  }
  
  public func remove(_ node: Node) -> T {
    let prev = node.previous
    let next = node.next
    
    if let prev = prev {
      prev.next = next
    } else {
      head = next
    }
    
    next?.previous = prev
    
    node.previous = nil
    node.next = nil
    return node.value
  }
  
  public func removeLast() -> T {
    assert(!isEmpty)
    return remove(last!)
  }
  
  public func removeAt(_ index: Int) -> T {
    let node = nodeAt(index)
    assert(node != nil)
    return remove(node!)
  }
  
  public func reverse() {
    var node = head
    while let currentNode = node {
      node = currentNode.next
      swap(&currentNode.next, &currentNode.previous)
      head = currentNode
    }
  }
  
  public func map<U>(transform: (T) -> U) -> LinkedList<U> {
    let result = LinkedList<U>()
    var node = head
    while node != nil {
      result.append(transform((node?.value)!))
      node = node?.next
    }
    return result
  }
  
  public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
    let result = LinkedList<T>()
    var node = head
    
    while node != nil {
      if predicate(node!.value) {
        result.append(node!.value)
      }
      node = node!.next
    }
    
    return result
  }
}

extension LinkedList: CustomStringConvertible {
  public var description: String {
    var s = "["
    var node = first
    while node != nil {
      s += "\(node!.value)"
      node = node!.next
      if node != nil { s += ", " }
    }
    return s + "]"
  }
}

let list = LinkedList<String>()
list.isEmpty
list.first
list.last

list.append("Hello")
list.isEmpty
list.first?.value
list.last?.value

list.append("World")
list.first?.previous
list.first?.next?.value
list.last?.previous?.value
list.last?.next

list.nodeAt(0)?.value
list.nodeAt(1)?.value
list.nodeAt(2)

list[0]
list[1]
//list[2]

list.insert(value: "Swift", atIndex: 1)
list[0]
list[1]
list[2]

list.insert(value: "front", atIndex: 0)
list.insert(value: "back", atIndex: 4)
list[0]
list[1]
list[2]
list[3]
list[4]

//dump(list)
//list.removeAll()
//dump(list)

list.remove(list.first!)
list.count
list[0]
list[1]

list.removeLast()
list.count
list[0]

list.removeAt(0)
list.count

list.description

list.reverse()



let list2 = LinkedList<String>()
list2.append("Hello")
list2.append("Swifty")
list2.append("Universe")

let m = list2.map { s in s.characters.count }
m



































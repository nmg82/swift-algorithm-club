public struct Stack<T> {
  fileprivate var array = [T]()
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  public mutating func push(_ element: T) {
    array.append(element)
  }
  
  public mutating func pop() -> T? {
    return array.popLast()
  }
  
  public func peek() -> T? {
    return array.last
  }
}

var stack = Stack<Int>()
stack.push(2)
stack.push(9)
stack.push(4)

stack.array

stack.peek()
stack.pop()

stack.array

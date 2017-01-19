//: [Previous](@previous)

struct Stack<T> {
  fileprivate var array: [T] = []
}

extension Stack {
  mutating func push(_ element: T) {
    array.append(element)
  }
  
  mutating func pop() -> T? {
    return array.popLast()
  }
}

extension Stack {
  func peek() -> T? {
    return array.last
  }
}

extension Stack: CustomStringConvertible {
  var description: String {
    let topDivider = "---Stack---\n"
    let bottomDivider = "\n-----------\n"
    
    let stackElements = array.map { "\($0)" }.reversed().joined(separator: "\n")
    
    return topDivider + stackElements + bottomDivider

  }
}

var s = Stack<String>()

s.push("Test")
s.peek()
s.pop()
s.pop()

//: [Next](@next)

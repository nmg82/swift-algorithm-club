//: [Previous](@previous)

//: A queue is not always the best choice. If the order in which the items are added and removed from the list isn't important, you might as well use a stack instead of a queue. Stacks are simpler and faster.

//public struct Queue<T> {
//  fileprivate var array = [T]()
//  
//  public var isEmpty: Bool {
//    return array.isEmpty
//  }
//  
//  public var count: Int {
//    return array.count
//  }
//  
//  public mutating func enqueue(_ element: T) {
//    array.append(element)
//  }
//  
//  public mutating func dequeue() -> T? {
//    if isEmpty {
//      return nil
//    } else {
//      return array.removeFirst()
//    }
//  }
//  
//  public func peek() -> T? {
//    return array.first
//  }
//}

//: A more efficient queue
public struct Queue<T> {
  fileprivate var array = [T?]()
  fileprivate var head = 0
  
  public var isEmpty: Bool {
    return count == 0
  }
  
  public var count: Int {
    return array.count - head
  }
  
  public mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    guard head < array.count, let element = array[head] else { return nil }
    
    array[head] = nil
    head += 1
    
    
    /*This calculates the percentage of empty spots at the beginning as a ratio of the total array size. If more than 25% of the array is unused, we chop off that wasted space. However, if the array is small we don't want to resize it all the time, so there must be at least 50 elements in the array before we try to trim it.
    
    Note: I just pulled these numbers out of thin air -- you may need to tweak them based on the behavior of your app in a production environment.*/
    let percentage = Double(head) / Double(array.count)
    
    if array.count > 50 && percentage > 0.25 {
//    if head > 2 {
      array.removeFirst(head)
      head = 0
    }
    
    return element
  }
  
  public func peek() -> T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}

var q = Queue<String>()
q.array                   // [] empty array

q.enqueue("Ada")
q.enqueue("Steve")
q.enqueue("Tim")
q.array             // [{Some "Ada"}, {Some "Steve"}, {Some "Tim"}]
q.count             // 3

q.dequeue()         // "Ada"
q.array             // [nil, {Some "Steve"}, {Some "Tim"}]
q.count             // 2

q.dequeue()         // "Steve"
q.array             // [nil, nil, {Some "Tim"}]
q.count             // 1

q.enqueue("Grace")
q.array             // [nil, nil, {Some "Tim"}, {Some "Grace"}]
q.count             // 2

q.dequeue()         // "Tim"
q.array             // [{Some "Grace"}]
q.count             // 1

//: [Next](@next)

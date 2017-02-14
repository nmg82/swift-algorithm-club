public struct Queue<T> {
  public var array: [T]
  
  public init() {
    array = []
  }
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  public mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    guard !array.isEmpty else { return nil }
    return array.removeFirst()
  }
  
  public func peek() -> T? {
    return array.first
  }
}

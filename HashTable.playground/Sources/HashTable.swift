/*
 Hash Table: A symbol table of generic key-value pairs.
 
 The key must be `Hashable`, which means it can be transformed into a fairly
 unique integer value. The more unique the hash value, the better.
 
 Hash tables use an internal array of buckets to store key-value pairs. The
 hash table's capacity is determined by the number of buckets. This
 implementation has a fixed capacity--it does not resize the array as more
 key-value pairs are inserted.
 
 To insert or locate a particular key-value pair, a hash function transforms the
 key into an array index. An ideal hash function would guarantee that different
 keys map to different indices. In practice, however, this is difficult to
 achieve.
 
 Since different keys can map to the same array index, all hash tables implement
 a collision resolution strategy. This implementation uses a strategy called
 separate chaining, where key-value pairs that hash to the same index are
 "chained together" in a list. For good performance, the capacity of the hash
 table should be sufficiently large so that the lists are small.
 
 A well-sized hash table provides very good average performance. In the
 worst-case, however, all keys map to the same bucket, resulting in a list that
 that requires O(n) time to traverse.
 
 Average Worst-Case
 Space:   O(n)     O(n)
 Search:  O(1)     O(n)
 Insert:  O(1)     O(n)
 Delete:  O(1)     O(n)
 */

public struct HashTable<Key: Hashable, Value> {
  fileprivate typealias Element = (key: Key, value: Value)
  fileprivate typealias Bucket = [Element]
  fileprivate var buckets: [Bucket]
  
  private(set) public var count = 0 //the number of key-value pairs in the hash table
  
  public var isEmpty: Bool { return count == 0 }
  
  public init(capacity: Int) {
    assert(capacity > 0)
    buckets = Array<Bucket>(repeating: [], count: capacity)
  }
  
  public subscript(key: Key) -> Value? {
    get {
      return value(forKey: key)
    }
    
    set {
      if let value = newValue {
        updateValue(value, forKey: key)
      } else {
        //removeValue(forKey: key)
      }
    }
  }
  
  public func value(forKey key: Key) -> Value? {
    let index = self.index(forKey: key)
    
    for element in buckets[index] {
      if element.key == key {
        return element.value
      }
    }
    
    return nil
  }
  
  private func index(forKey key: Key) -> Int {
    return abs(key.hashValue) % buckets.count
  }
  
  @discardableResult public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
    let index = self.index(forKey: key)
    
    for (i, element) in buckets[index].enumerated() {
      if element.key == key {
        buckets[index][i].value = value
        let oldValue = element.value
        return oldValue
      }
    }
    
    buckets[index].append((key: key, value: value))
    count += 1
    return nil
  }
  
  @discardableResult public mutating func removeValue(forKey key: Key) -> Value? {
    let index = self.index(forKey: key)
    
    for (i, element) in buckets[index].enumerated() {
      if element.key == key {
        buckets[index].remove(at: i)
        count -= 1
        return element.value
      }
    }
    
    return nil
  }
  
  public mutating func removeAll() {
    buckets = Array<Bucket>(repeating: [], count: buckets.count)
    count = 0
  }
}

extension HashTable: CustomStringConvertible {
  public var description: String {
    let pairs = buckets.flatMap { b in b.map { e in "\(e.key) = \(e.value)" } }
    return pairs.joined(separator: ", ")
  }
}

extension HashTable: CustomDebugStringConvertible {
  public var debugDescription: String {
    var str = ""
    for (i, bucket) in buckets.enumerated() {
      let pairs = bucket.map { e in "\(e.key) = \(e.value)" }
      str += "bucket \(i): " + pairs.joined(separator: ", ") + "\n"
    }
    return str
  }
}

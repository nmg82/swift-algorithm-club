public class TrieNode<T: Hashable> {
  var value: T?
  weak var parent: TrieNode?
  var children: [T: TrieNode] = [:]
  var isTerminating = false
  
  init(value: T? = nil, parent: TrieNode? = nil) {
    self.value = value
    self.parent = parent
  }
}

extension TrieNode {
  func add(child: T) {
    guard children[child] == nil else { return }
    children[child] = TrieNode(value: child, parent: self)
  }
}


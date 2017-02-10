public class Graph: Equatable {
  public private(set) var nodes: [Node]
  
  public init() {
    nodes = []
  }
  
  public func addNode(_ label: String) -> Node {
    let node = Node(label)
    nodes.append(node)
    return node
  }
  
  public func addEdge(_ source: Node, neighbor: Node) {
    let edge = Edge(neighbor)
    source.neighbors.append(edge)
  }
  
  public func findNodeWithLabel(_ label: String) -> Node {
    guard let result = (nodes.filter { $0.label == label }.first)
      else {
        fatalError("Node with label: <\(label)> not found")
      }
    
    return result
  }
  
  public func duplicate() -> Graph {
    let duplicated = Graph()
    
    for node in nodes {
      let _ = duplicated.addNode(node.label)
      
      for edge in node.neighbors {
        let source = duplicated.findNodeWithLabel(node.label)
        let neighbor = duplicated.findNodeWithLabel(edge.neighbor.label)
        duplicated.addEdge(source, neighbor: neighbor)
      }
    }
    
    return duplicated
  }
}

extension Graph {
  public func breadthFirstSearch(source: Node) -> [String] {
    var queue = Queue<Node>()
    queue.enqueue(source)
    
    var nodesExplored = [source.label]
    source.visited = true
    
    while let node = queue.dequeue() {
      for edge in node.neighbors {
        let neighbor = edge.neighbor
        if !neighbor.visited {
          queue.enqueue(neighbor)
          neighbor.visited = true
          nodesExplored.append(neighbor.label)
        }
      }
    }
    
    return nodesExplored
  }
}

extension Graph: CustomStringConvertible {
  public var description: String {
    var description = ""
    
    for node in nodes {
      if !node.neighbors.isEmpty {
        description += "[node: \(node.label) edges: \(node.neighbors.map { $0.neighbor.label})]"
      }
    }
    
    return description
  }
}

public func == (_ lhs: Graph, rhs: Graph) -> Bool {
  return lhs.nodes == rhs.nodes
}

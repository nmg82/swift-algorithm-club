private class EdgeList<T> where T: Equatable, T: Hashable {
  var vertex: Vertex<T>
  var edges: [Edge<T>]? = nil
  
  init(vertex: Vertex<T>) {
    self.vertex = vertex
  }
  
  func addEdge(_ edge: Edge<T>) {
    edges?.append(edge)
  }
}

public class AdjacencyListGraph<T>: AbstractGraph<T> where T: Equatable, T: Hashable {
  fileprivate var adjacencyList: [EdgeList<T>] = []
  
  public required init() {
    super.init()
  }
  
  public required init(fromGraph graph: AbstractGraph<T>) {
    super.init(fromGraph: graph)
  }
  
  override public var vertices: [Vertex<T>] {
    var vertices = [Vertex<T>]()
    for edgeList in adjacencyList {
      vertices.append(edgeList.vertex)
    }
    return vertices
  }
  
  override public var edges: [Edge<T>] {
    var allEdges = Set<Edge<T>>()
    for edgeList in adjacencyList {
      guard let edges = edgeList.edges else {
        continue
      }
      
      for edge in edges {
        allEdges.insert(edge)
      }
    }
    return Array(allEdges)
  }
  
  override public func createVertex(_ data: T) -> Vertex<T> {
    //check if the vertex already exists
    let matchingVertices = vertices.filter { $0.data == data }
    
    if matchingVertices.count > 0 {
      return matchingVertices.last!
    }
    
    //if the vertex doesn't exist, create a new one
    let vertex = Vertex(data: data, index: adjacencyList.count)
    adjacencyList.append(EdgeList(vertex: vertex))
    
    return vertex
  }
  
  override public func addDirectedEdge(_ from: Vertex<T>, to: Vertex<T>, withWeight weight: Double?) {
    let edge = Edge(from: from, to: to, weight: weight)
    let edgeList = adjacencyList[from.index]
    
    if let _ = edgeList.edges {
      edgeList.addEdge(edge)
    } else {
      edgeList.edges = [edge]
    }
  }
  
  override public func addUndirectedEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
    addDirectedEdge(vertices.0, to: vertices.1, withWeight: weight)
    addDirectedEdge(vertices.1, to: vertices.0, withWeight: weight)
  }
  
  override public func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
    guard let edges = adjacencyList[sourceVertex.index].edges else { return nil }
    
    for edge: Edge<T> in edges {
      if edge.to == destinationVertex {
        return edge.weight
      }
    }
    
    return nil
  }
  
  override public func edgesFrom(_ sourceVertex: Vertex<T>) -> [Edge<T>] {
    return adjacencyList[sourceVertex.index].edges ?? []
  }
  
  override public var description: String {
    var rows = [String]()
    
    for edgeList in adjacencyList {
      guard let edges = edgeList.edges else { continue }
      
      var row = [String]()
      for edge in edges {
        var value = "\(edge.to.data)"
        if edge.weight != nil {
          value = "(\(value): \(edge.weight))"
        }
        row.append(value)
      }
      
      rows.append("\(edgeList.vertex.data) -> [\(row.joined(separator: ", "))]")
    }
    
    return rows.joined(separator: "\n")
  }
}



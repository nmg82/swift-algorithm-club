import Foundation

public class AdjacencyList<T: Hashable> {
  var adjacencyDict: [Vertex<T>: [Edge<T>]] = [:]
  public init() {}
}

fileprivate extension AdjacencyList {
  func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
    let edge = Edge(source: source, destination: destination, weight: weight)
    adjacencyDict[source]?.append(edge)
  }
  
  func addUndirectedEdge(vertices: (Vertex<Element>, Vertex<Element>), weight: Double?) {
    let (source, destination) = vertices
    addDirectedEdge(from: source, to: destination, weight: weight)
    addDirectedEdge(from: destination, to: source, weight: weight)
  }
}

extension AdjacencyList: Graphable {
  typealias Element = T
  
  public func createVertex(data: T) -> Vertex<T> {
    let vertex = Vertex(data: data) //Based on the data passed in you create a Vertex
    
    if adjacencyDict[vertex] == nil { //You check to see if the vertex already exist. If it doesn’t you initialize an array of edges and return the vertex.
      adjacencyDict[vertex] = []
    }
    
    return vertex
  }
  
  public func add(_ type: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
    switch type {
      case .directed:
        addDirectedEdge(from: source, to: destination, weight: weight)
      case .undirected:
        addUndirectedEdge(vertices: (source, destination), weight: weight)
    }
  }
  
  public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
    guard let edges = adjacencyDict[source] else { return nil }
    
    for edge in edges { //Check to see if there is an edge that leads to the destination vertex.
      if edge.destination == destination {
        return edge.weight
      }
    }
    
    return nil //No weight found
  }
  
  public func edges(from source: Vertex<T>) -> [Edge<T>]? {
    return adjacencyDict[source]
  }
  
  public var description: CustomStringConvertible {
    var result = ""
    
    for (vertex, edges) in adjacencyDict {
      var edgeString = ""
      
      for (index, edge) in edges.enumerated() {
        if index != edges.count - 1 {
          edgeString.append("\(edge.destination), ")
        } else {
          edgeString.append("\(edge.destination)")
        }
      }
      
      result.append("\(vertex) ---> [ \(edgeString) ] \n")
    }
    
    return result
  }
}

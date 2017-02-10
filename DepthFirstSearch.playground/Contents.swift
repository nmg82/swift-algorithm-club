//Depth-first search (DFS) starts at a source node and explores as far as possible along each branch before backtracking.

//In depth-first search we look at the starting node's first neighbor and visit that

func depthFirstSearch(source: Node) -> [String] {
  var nodesExplored = [source.label]
  source.visited = true
  
  //Each time we visit the first neighbor and keep going until there's nowhere left to go, and then we backtrack to a point where there are again nodes to visit. When we've backtracked all the way to the first node, the search is complete.
  for edge in source.neighbors {
    if !edge.neighbor.visited {
      nodesExplored += depthFirstSearch(source: edge.neighbor)
    }
  }
  
  return nodesExplored
}

let graph = Graph()

let nodeA = graph.addNode("a")
let nodeB = graph.addNode("b")
let nodeC = graph.addNode("c")
let nodeD = graph.addNode("d")
let nodeE = graph.addNode("e")
let nodeF = graph.addNode("f")
let nodeG = graph.addNode("g")
let nodeH = graph.addNode("h")

graph.addEdge(nodeA, neighbor: nodeB)
graph.addEdge(nodeA, neighbor: nodeC)
graph.addEdge(nodeB, neighbor: nodeD)
graph.addEdge(nodeB, neighbor: nodeE)
graph.addEdge(nodeC, neighbor: nodeF)
graph.addEdge(nodeC, neighbor: nodeG)
graph.addEdge(nodeE, neighbor: nodeH)
graph.addEdge(nodeE, neighbor: nodeF)
graph.addEdge(nodeF, neighbor: nodeG)

let nodesExplored = depthFirstSearch(source: nodeA)
print(nodesExplored)

let nodesExplored2 = graph.depthFirstSearch(source: nodeA)
print(nodesExplored)

func breadthFirstSearch(source: Node) -> [String] {
  var queue = Queue<Node>()
  queue.enqueue(source) //1. add source to the queue
  
  var nodesExplored = [source.label] //2. add to explored array
  source.visited = true // 3. mark node as visited
  
  //4. As long as there are nodes in the queue, we visit the node that's at the front of the queue, and enqueue its immediate neighbor nodes if they have not been visited yet.
  while let node = queue.dequeue() {
    for edge in node.neighbors { // 5. Look at each of the dequeued node's neighbors
      let neighbor = edge.neighbor
      if !neighbor.visited { //6. Ensure the neighbor hasn't been visted yet already
        queue.enqueue(neighbor) //7. Enqueue the unvisited neighbor
        neighbor.visited = true //8. Mark the now visited neighbor as visited
        nodesExplored.append(neighbor.label) //9. Append the now visited neighbor to the array of explored nodes
      }
    }
  }
  
  return nodesExplored //10. Once the queue is empty, return all the explored nodes
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

//let nodesExplored = breadthFirstSearch(source: nodeA)
//print(nodesExplored)

let nodesExplored2 = graph.breadthFirstSearch(source: nodeA)
print(nodesExplored2)

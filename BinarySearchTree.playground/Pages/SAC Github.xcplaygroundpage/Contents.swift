//: [rw article walkthrough](@previous)

//:The height of a node is the number of steps it takes to go from that node to its lowest leaf. The height of the entire tree is the distance from the root to the lowest leaf. Many of the operations on a binary search tree are expressed in terms of the tree's height.


//let tree = BinarySearchTree<Int>(value: 7)
//tree.insert(2)
//tree.insert(5)
//tree.insert(10)
//tree.insert(9)
//tree.insert(1)

//duplicates always get inserted in the right branch
//let tree = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])
//tree.count
//print(tree)

//tree.search(5)
//tree.searchUsingLoop(5)
//tree.search(6)
//tree.searchUsingLoop(6)

//tree.traverseInOrder { print($0) }
//tree.toArray()

//if let node2 = tree.search(2) {
//  print("before removing 2: ", tree)
//  node2.remove()
//  print(" after removing 2: ", tree)
//}

//tree.remove()
//print(tree)

//tree.height()
//
//if let node9 = tree.search(9) {
//  node9.depth()
//}
//
//if let node1 = tree.search(1) {
//  tree.isBST(minValue: Int.min, maxValue: Int.max)
//  node1.insert(100) // BadThing™
//  tree.search(100) // not found because you didn't insert 100 into the root of the tree
//  tree.isBST(minValue: Int.min, maxValue: Int.max) // no longer a binary search tree due to imbalance
//}

var tree = BST.leaf(7)
tree = tree.insert(2)
tree = tree.insert(5)
tree = tree.insert(10)
tree = tree.insert(9)
tree = tree.insert(1)

tree.search(10)
tree.search(1)
tree.search(11)   // nil

print(tree)

//: [rw article walkthrough](@previous) -- [Next](@next)

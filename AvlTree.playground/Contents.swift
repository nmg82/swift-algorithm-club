//: * An AVL tree is a self-balancing form of a binary search tree, in which the height of subtrees differ at most by only 1.
//: * A node in an AVL tree is considered balanced if its subtrees differ in "height" by at most 1. 
//: * The tree itself is balanced if all its nodes are balanced.
//: * The height of a node is how many steps it takes to get to that node's lowest leaf.

//: The difference between the heights of the left and right subtrees is called the balance factor. It is calculated as follows:
//: * balance factor = abs(height(left subtree) - height(right subtree))

//: Playground - noun: a place where people can play

let tree = AVLTree<Int, String>()

tree.insert(5, payload: "five")
print(tree)

tree.insert(4, payload: "four")
print(tree)

tree.insert(3, payload: "three")
print(tree)

tree.insert(2, payload: "two")
print(tree)

tree.insert(1, payload: "one")
print(tree)
print(tree.debugDescription)

let node = tree.search(2)   // "two"

tree.delete(key: 5)
tree.delete(key: 2)
tree.delete(key: 1)
tree.delete(key: 4)
tree.delete(key: 3)























































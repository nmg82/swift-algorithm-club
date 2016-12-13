//: [rw article walkthrough](@previous)
/*
 * A tree consists of nodes, and these nodes are linked to one another.
 * A node without a parent is the root node. A node without children is a leaf node.
 * The pointers in a tree do not form cycles.
 */

/*
 * Height of the tree. This is the number of links between the root node and the lowest leaf. In our example the height of the tree is 3 because it takes three jumps to go from the root to the bottom.
 
 * Depth of a node. The number of links between this node and the root node. For example, the depth of tea is 2 because it takes two jumps to reach the root. (The root itself has depth 0.)
 */

public class TreeNode<T> {
  public var value: T
  public weak var parent: TreeNode?
  public var children = [TreeNode<T>]()
  
  public init(value: T) {
    self.value = value
  }
  
  public func addChild(_ node: TreeNode<T>) {
    children.append(node)
    node.parent = self
  }
}

extension TreeNode where T: Equatable {
  func search(_ value: T) -> TreeNode? {
    if value == self.value { return self }
    
    for child in children {
      if let found = child.search(value) {
        return found
      }
    }
    
    return nil
  }
}

extension TreeNode: CustomStringConvertible {
  public var description: String {
    var s = "\(value)"
    if !children.isEmpty {
      s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
    }
    return s
  }
}

let tree = TreeNode<String>(value: "beverages")

let hotNode = TreeNode<String>(value: "hot")
let coldNode = TreeNode<String>(value: "cold")

let teaNode = TreeNode<String>(value: "tea")
let coffeeNode = TreeNode<String>(value: "coffee")
let chocolateNode = TreeNode<String>(value: "cocoa")

let blackTeaNode = TreeNode<String>(value: "black")
let greenTeaNode = TreeNode<String>(value: "green")
let chaiTeaNode = TreeNode<String>(value: "chai")

let sodaNode = TreeNode<String>(value: "soda")
let milkNode = TreeNode<String>(value: "milk")

let gingerAleNode = TreeNode<String>(value: "ginger ale")
let bitterLemonNode = TreeNode<String>(value: "bitter lemon")

tree.addChild(hotNode)
tree.addChild(coldNode)

hotNode.addChild(teaNode)
hotNode.addChild(coffeeNode)
hotNode.addChild(chocolateNode)

coldNode.addChild(sodaNode)
coldNode.addChild(milkNode)

teaNode.addChild(blackTeaNode)
teaNode.addChild(greenTeaNode)
teaNode.addChild(chaiTeaNode)

sodaNode.addChild(gingerAleNode)
sodaNode.addChild(bitterLemonNode)

//print(tree)
//dump(tree)

tree.search("cocoa")
tree.search("chai")
tree.search("bubbly")

//:[rw article walkthrough](@previous) -- [Next](@next)

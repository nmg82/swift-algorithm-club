class Node {
  let value: String
  var children = [Node]()
  weak var parent: Node?
  
  init(value: String) {
    self.value = value
  }
  
  func addChild(node: Node) {
    children.append(node)
    node.parent = self
  }
}

extension Node: CustomStringConvertible {
  var description: String {
    var text = "\(value)"
    if !children.isEmpty {
      text += " {" + children.map{ $0.description }.joinWithSeparator(", ") + "} "
    }
    return text
  }
}

extension Node {
  func search(value: String) -> Node? {
    if value == self.value {
      return self
    }
    
    for child in children {
      if let found = child.search(value) {
        return found
      }
    }
    
    return nil
  }
}

let beverages = Node(value: "beverages")
let hotBeverage = Node(value: "hot")
let coldBeverage = Node(value: "cold")

let tea = Node(value: "tea")
let coffee = Node(value: "coffee")
let chocolate = Node(value: "cocoa")

let blackTea = Node(value: "black")
let greenTea = Node(value: "green")
let chaiTea = Node(value: "chai")

let soda = Node(value: "soda")
let milk = Node(value: "milk")

let gingerAle = Node(value: "ginger ale")
let bitterLemon = Node(value: "bitter lemon")

beverages.addChild(hotBeverage)
beverages.addChild(coldBeverage)

hotBeverage.addChild(tea)
hotBeverage.addChild(coffee)
hotBeverage.addChild(chocolate)

coldBeverage.addChild(soda)
coldBeverage.addChild(milk)

tea.addChild(blackTea)
tea.addChild(greenTea)
tea.addChild(chaiTea)

soda.addChild(gingerAle)
soda.addChild(bitterLemon)

print(beverages)

beverages.search("cocoa")
beverages.search("chai")
beverages.search("bubbly")

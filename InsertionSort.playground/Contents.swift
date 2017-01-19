//: You are given an array of numbers and need to put them in the right order. The insertion sort algorithm works as follows:
//: * Put the numbers on a pile. This pile is unsorted.
//: * Pick a number from the pile. It doesn't really matter which one you pick, but it's easiest to pick from the top of the pile.
//: * Insert this number into a new array.
//: * Pick the next number from the unsorted pile and also insert that into the new array. It either goes before or after the first number you picked, so that now these two numbers are sorted.
//: * Again, pick the next number from the pile and insert it into the array in the proper sorted position.
//: * Keep doing this until there are no more numbers on the pile. You end up with an empty pile and an array that is sorted.

extension Array where Element: Comparable {
  func insertionSort() -> [Element] {
    var result = self
    
    for primaryIndex in 1 ..< result.count {
      var secondaryIndex = primaryIndex
      
      while secondaryIndex > 0 && result[secondaryIndex] < result[secondaryIndex - 1] {
        swap(&result[secondaryIndex-1], &result[secondaryIndex])
        secondaryIndex -= 1
      }
    }
    
    return result
  }
  
  func insertionSortNoSwap() -> [Element] {
    var result = self
    
    for primaryIndex in 1 ..< result.count {
      var secondaryIndex = primaryIndex
      let temp = result[secondaryIndex]
      
      while secondaryIndex > 0 && temp < result[secondaryIndex - 1] {
        result[secondaryIndex] = result[secondaryIndex - 1]
        secondaryIndex -= 1
      }
      
      result[secondaryIndex] = temp
    }
    
    return result
  }
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
list.insertionSort()
list.insertionSortNoSwap()

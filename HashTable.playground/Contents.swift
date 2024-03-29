"firstName".hashValue
abs("firstName".hashValue) % 5

"lastName".hashValue
abs("lastName".hashValue) % 5

"hobbies".hashValue
abs("hobbies".hashValue) % 5



var hashTable = HashTable<String, String>(capacity: 5)

hashTable["firstName"] = "Steve"   // insert
let x = hashTable["firstName"]     // lookup
hashTable["firstName"] = "Tim"     // update
hashTable["firstName"] = nil       // delete



hashTable = HashTable<String, String>(capacity: 5)

hashTable["firstName"] = "Steve"
hashTable["lastName"] = "Jobs"
hashTable["hobbies"] = "Programming Swift"

print(hashTable)
print(hashTable.debugDescription)

let firstName = hashTable["firstName"]
hashTable["firstName"] = "Tim"

let y = hashTable["firstName"]
hashTable["firstName"] = nil

let z = hashTable["firstName"]

print(hashTable)
print(hashTable.debugDescription)

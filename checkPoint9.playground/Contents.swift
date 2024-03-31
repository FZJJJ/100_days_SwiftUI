import Cocoa

func randomNum(arr: [Int]?) -> Int {
    return arr?.randomElement() ?? Int.random(in: 1...100)
}

print(randomNum(arr: nil))
print(randomNum(arr: [1, 2, 3]))

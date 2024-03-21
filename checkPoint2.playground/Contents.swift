import Cocoa

let colors: [String] = ["red", "blue", "yellow", "pink", "blue", "pink"]
let arrayNum = colors.count
let colorsSet = Set(colors)
let setNum = colorsSet.count

print("The array's count is \(arrayNum)")
print("The colors' count is \(setNum)")

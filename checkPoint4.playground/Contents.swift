import Cocoa

enum SquareError: Error {
    case OutOfBounds
    case NoRoot
}

func FindSqrt(for num: Int) throws -> Int{
    if num < 1 || num > 10000 {
        throw SquareError.OutOfBounds
    }
    for i in 1...100 {
        if i * i == num {
            return i
        }
    }
    throw SquareError.NoRoot
}

let number = 79
do {
    let result = try FindSqrt(for: number)
    print("The square of \(number) is \(result)")
} catch SquareError.OutOfBounds{
    print("There is an error: Out of boounds")
} catch SquareError.NoRoot {
    print("There is an error: No root")
}

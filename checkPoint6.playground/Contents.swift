import Cocoa

struct Car {
    let model: String
    let numberOfSeats: Int
    static var currentGear: Int = 1
    func changeGear(for num: Int) {
        if Car.currentGear + num < 1 {
            Car.currentGear = 1
        } else if Car.currentGear + num > 10 {
            Car.currentGear = 10
        } else {
            Car.currentGear += num
        }
    }
}

let car = Car(model: "BMW", numberOfSeats: 4)
print(car)
car.changeGear(for: 5)
print(Car.currentGear)
car.changeGear(for: -3)
print(Car.currentGear)

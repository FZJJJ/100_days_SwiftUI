import Cocoa

class Animal {
    let legs: Int
    init(leg_num: Int) {
        self.legs = leg_num
    }
}

class Dog: Animal {
    let breed: String
    func speak() {
        print("wangwangwang!")
    }
    init(breed: String){
        self.breed = breed
        super.init(leg_num: 4)
    }
}

class Corgi: Dog {
    override func speak() {
        print("Corgi: wangwangwang!")
    }
    init(){
        super.init(breed: "Corgi")
    }
}
class Poodle: Dog {
    override func speak() {
        print("Poodle: wangwangwang!")
    }
    init(){
        super.init(breed: "Poodle")
    }
}

let dog1 = Poodle()
dog1.speak()
let dog2 = Corgi()
dog2.speak()

class Cat: Animal {
    let breed: String
    let isTame: Bool
    func speak() {
        print("miaomiaomiao!")
    }
    init(breed: String, isTame: Bool){
        self.breed = breed
        self.isTame =  isTame
        super.init(leg_num: 4)
    }
}

class Persian: Cat {
    override func speak() {
        print("Persian: miaomiaomiao!")
    }
    init(){
        super.init(breed: "Persian", isTame: true)
    }
}
class Lion: Cat {
    override func speak() {
        print("Lion: miaomiaomiao!")
    }
    init(){
        super.init(breed: "Lion", isTame: true)
    }
}

let cat1 = Persian()
cat1.speak()
let cat2 = Lion()
cat2.speak()

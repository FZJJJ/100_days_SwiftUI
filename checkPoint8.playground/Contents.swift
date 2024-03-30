import Cocoa

protocol Building {
    var room_num: Int {get}
    var cost: Int {get}
    var agent_name: String {get}
    func saleSummary()
}

struct House: Building {
    let room_num: Int = 3
    let cost: Int = 100_000_000
    let agent_name: String = "FZJ"
    func saleSummary() {
        print("The house has \(room_num) rooms, it costs \(cost)$ and the agent is \(agent_name)")
    }
}

struct Office: Building {
    let room_num: Int = 10
    let cost: Int = 500_000_000
    let agent_name: String = "WXW"
    func saleSummary() {
        print("The office has \(room_num) rooms, it costs \(cost)$ and the agent is \(agent_name)")
    }
}

let building1 = House()
let building2 = Office()
building1.saleSummary()
building2.saleSummary()

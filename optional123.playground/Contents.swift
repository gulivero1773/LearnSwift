import UIKit

class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
    return rooms.count
}
subscript(i: Int) -> Room {
    get {
        return rooms[i]
    }
    set {
        rooms[i] = newValue
    }
}
    func printNumberOfRooms() {
        print("\(numberOfRooms)")
    }
    var address: Address?

}


class Room {
    let name: String
    init(name: String) {self.name = name}
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIndetifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

let john = Person()

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia"
john.residence?.address = someAddress




func createAddress() -> Address {
    print("Ункция")
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia"
    john.residence?.address = someAddress

return someAddress
}

john.residence?.address = createAddress()




if john.residence?.printNumberOfRooms() != nil {
    print("есть возможнасть")
} else {
    print("нет")
}



if(john.residence?.address = someAddress) != nil {
    print("да")
} else {
    print("нет")
}



if let firstRoomName = john.residence?[0].name {
    print("Название перовй \(firstRoomName)")
} else {
    print("никак")
}


john.residence?[0] = Room(name: "спальня")

let johnHouse = Residence()
johnHouse.rooms.append(Room(name: "Гостинная"))
    johnHouse.rooms.append(Room(name: "кухня"))
    john.residence = johnHouse

if let firstRoomName = john.residence?[0].name {
    print("Название перовй \(firstRoomName)")
} else {
    print("никак")
}





//
//let john = Person()
//
////let roomCount = john.residence!.numberOfRooms
//
//if let roomCount = john.residence?.numberOfRooms {
//    print("\(roomCount)")
//} else {
//    print("Невозможно")
//}
//
//
//john.residence = Residence()
//
//
//if let roomCount = john.residence?.numberOfRooms {
//    print("\(roomCount)")
//} else {
//    print("Невозможно")
//}
//
//

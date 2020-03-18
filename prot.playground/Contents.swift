//import UIKit
//
//protocol SomeProtocol {
//
//}
//
//class SomeClass: SomeSuperClass, SomeProtocol {
//
//}



protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSattable: Int { get }
}
protocol AnotherProtocol {
    static var someTypeproperty: Int { get set }
}

protocol FullNamed {
    var fullName: String { get }
}

struct Person: FullNamed {
    var fullName: String
}

let john = Person(fullName: "John")
print(john.fullName)










import UIKit



//Functional Approach
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let filted = numbers.filter{$0 % 2 != 0}
//[2, 4, 6, 8, 10]
print(filted)




let fibonacci = sequence(first: (0, 1), next: { ($1, $0 + $1) })
                .prefix(20).map{$0.0}
                .filter {$0 % 2 == 0 && $0 < 4000}
print (fibonacci)
// [0, 2, 8, 34, 144, 610, 2584]



let fibonacci1 = sequence(first: (0, 1), next: { ($1, $0 + $1) })
                .prefix(20).map{$0.0}
                .filter {$0 % 2 == 0 && $0 < 4000}
print (fibonacci1)
// [0, 2, 8, 34, 144, 610, 2584]

print(fibonacci1.reduce(0,+))
// 3382


// Separate Tuples
let arr = [("one", 1), ("two", 2), ("three", 3), ("four", 4)]
let (arr1, arr2) = arr.reduce(([], [])) {
                             ($0.0 + [$1.0], $0.1 + [$1.1]) }

print(arr1) // ["one", "two", "three", "four"]
print(arr2) // [1, 2, 3, 4]


// Remove duplicates
let arrayInt = [1,1,2,6,6,7,2,9,7].reduce(into: []) {
    !$0.contains($1) ? $0.append($1) : () }
// [1, 2, 6, 7, 9]


// Count equal elements in array
let arrayIntCount = [1,1,2,2,6,6,7,2,9,7].reduce(into: [:]) {
          counts, letter in  counts[letter, default: 0] += 1  }
// [6: 2, 9: 1, 1: 2, 2: 3, 7: 2]

let maybeNumbers = ["42", "7", "three", "///4///", "5"]

let firstNumber = maybeNumbers.map (Int.init).first





struct SetCard: Equatable {
    let number: Variant // number - 1, 2, 3
    let color: Variant  // color  - 1, 2, 3 (например, красный, зеленый, фиолетовый)
    let shape: Variant  // symbol - 1, 2, 3 (например, ромб, волна, овал)
    let fill: Variant   // fill   - 1, 2, 3 (например, закрашен, заштрихован, пустой)
    
    enum Variant: Int, CaseIterable   {
        case v1 = 1
        case v2
        case v3
    }
    
    static func isSet(cards: [SetCard]) -> Bool {
        guard cards.count == 3 else {return false}
        let sums = [
            cards.reduce(0, { $0 + $1.number.rawValue }),
            cards.reduce(0, { $0 + $1.color.rawValue }),
            cards.reduce(0, { $0 + $1.shape.rawValue }),
            cards.reduce(0, { $0 + $1.fill.rawValue })
        ]
        return sums.reduce(true, { $0 && ($1 % 3 == 0) })
    }
}




var integerArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 4, 5]

func unique(_ array: [Int]) -> [Int] {
    return array.reduce(into: [], { (results, element) in
        if !results.contains(element) { results.append(element) }
    })
}

func even(_ array: [Int]) -> [Int] {
    return array.filter{ $0%2 == 0}
}

func square(_ array: [Int]) -> [Int] {
    return array.map{ $0*$0 }
}

var array = square(even(unique(integerArray))) // it returns [4, 16, 36, 64]



precedencegroup  ForwardComposition{
    associativity: left
    higherThan: ForwardApplication
}

infix operator >>> :  ForwardComposition

func >>> <A, B, C>(left: @escaping (A) -> B, right: @escaping (B) -> C) -> (A) -> C {
    return { right(left($0)) }
}

precedencegroup ForwardApplication {
    associativity: left
}

infix operator |> : ForwardApplication

func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}

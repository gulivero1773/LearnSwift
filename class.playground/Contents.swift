import UIKit


func getIntFromDB() -> Int
func getIntFromServer() -> Int?

func summInts() -> Int? {
    let intFromDB = getIntFromDB()
    let intFromServer = getIntFromServer()

    if let intFromServer = intFromServer {
        let summ = intFromDB + intFromServer
        return summ
    } else {
        return nil
    }
}

if let result = summInts() {
    print(result)
}

func getIntFromDB() -> Int
func getIntFromServer() -> Int?

func summInts() -> Int? {
    let intFromDB = getIntFromDB()
    let intFromServer = getIntFromServer()

    return intFromServer.map { x in x + intFromDB }
}

if let result = summInts() {
    print(result)
}

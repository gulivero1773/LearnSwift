

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}


class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
        
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}



let library = [
Movie(name: "ds", director: "sd"),
Song(name: "fdf", artist: "dsd "),
Movie(name: "sdsd", director: "asdsd"),
Song(name: "assd", artist: "dsdsd")
]


var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}


print("\(movieCount) \(songCount)")



for item in library {
    
    if let movie = item as? Movie {
        print("")
    } else if let song = item as? Song {
        print("\(song.name)")
    }
}


var thinks = [Any]()

thinks.append(0)
thinks.append(0.0)
thinks.append(3.23)
thinks.append(42)
thinks.append("Hello")
thinks.append(Movie(name: "sd", director: "dsds"))
thinks.append({(name: String) -> String in "Hello"})
//thinks.append(3.0, 5.0)



let optionalNumber: Int? = 3
thinks.append(optionalNumber as Any)

struct BlackJackCard {
    enum Suit: Character {
        case spades = "", hearts = "", diamonds = "", clubs = ""
    }
}



























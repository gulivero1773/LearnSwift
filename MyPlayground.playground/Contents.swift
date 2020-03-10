import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "ru.swift.sourcec", attributes: .concurrent)

let timer = DispatchSource.makeTimerSource(queue: queue)


timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300))
timer.setCancelHandler {
    print("Hello, world")
}
timer.setCancelHandler {
    print("Timer is cansled")
}
timer.resume()

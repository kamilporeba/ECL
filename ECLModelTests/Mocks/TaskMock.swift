@testable import ECLModel

class TaskMock: Task {
    var isResume: Bool = false
    func resume() {
        isResume = true
    }
    
}

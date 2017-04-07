


import Foundation

class UserManager {

    static let shared = UserManager()
    
    var users = [User]()
    
    private init() { }
        
        func removeAll() {
            users.removeAll()
        }
        
        func addUsers(_ user: User) {
            users.append(user)
        }
 
}

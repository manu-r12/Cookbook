

import Foundation


class LoginViewModel: ObservableObject {
    
    @Published var emailInput : String = ""
    @Published var password   : String = ""
}

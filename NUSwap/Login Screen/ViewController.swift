import UIKit

class ViewController: UIViewController {

    //MARK: initializing the First Screen View...
    let loginScreen = LoginView()
    let childProgressView = ProgressSpinnerViewController()

    let defaults = UserDefaults.standard
    
    //MARK: add the view to this controller while the view is loading...
    override func loadView() {
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        loginScreen.buttonLogin.addTarget(self, action: #selector(onButtonClickLoginTapped), for: .touchUpInside)
        loginScreen.buttonRegister.addTarget(self, action: #selector(onButtonClickRegisterTapped), for: .touchUpInside)
        
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }

    @objc func onButtonClickLoginTapped() {
        // Collect entered email and password
        guard let email = loginScreen.textFieldEmail.text, !email.isEmpty,
              let password = loginScreen.textFieldPassword.text, !password.isEmpty
        else {
            showErrorAlert(message: "Email and password cannot be empty.")
            return
        }
        
        // Validate the email format
        if !isValidNortheasternEmail(email) {
            showErrorAlert(message: "Please enter a valid Northeastern email (e.g., xyz@northeastern.edu).")
            return
        }
        
        // If both fields are non-empty, attempt login
        loginUserAPI(email: email, password: password)
    }

    // Helper function to validate Northeastern email format
    func isValidNortheasternEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Za-z0-9._%+-]+@northeastern\\.edu$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    // Show an alert with the given message
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    @objc func onButtonClickRegisterTapped() {
        // Instantiate the RegisterViewController
        let registerViewController = RegisterViewController()
        
        // Replace the current view stack to remove the LoginView
        navigationController?.setViewControllers([registerViewController], animated: true)
    }
    
    func loginUserAPI(email: String, password: String){
        signInToFirebase(email: email, password: password)
    }

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

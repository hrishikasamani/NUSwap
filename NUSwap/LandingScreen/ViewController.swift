import UIKit

class ViewController: UIViewController {

    let landingScreen = LoginView()
    
    override func loadView() {
        view = landingScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NU Swap"
        
        landingScreen.buttonNavigate.addTarget(self, action: #selector(onButtonClickNavigate), for: .touchUpInside)
    }
    
    @objc func onButtonClickNavigate() {
            // Create an instance of MainTabBarController
            let tabBarController = MainTabBarController()
            
            // Set the presentation style to full screen
            tabBarController.modalPresentationStyle = .fullScreen
            
            // Present the MainTabBarController
            present(tabBarController, animated: true, completion: nil)
        }
}

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //!!!Constants to struct!!!
    
    //MARK: - Fields
    private let label : UILabel = {
        let view = UILabel()
        view.text = "Sigma App"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: .init(40))
        return view
    }()
    
    private let loginTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter E-mail..."
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray6
        view.borderStyle = .roundedRect
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter password..."
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray6
        view.borderStyle = .roundedRect
        return view
    }()
    
    private let loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Login", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        return view
    }()
    
    //MARK: - Constraints
    func createLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    func createLoginConstraints() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginTextField)
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
    }
    
    func createPasswordConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30).isActive = true
    }
    
    func createButtonConstrainsts() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginTextField.widthAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //MARK: - Functions
    func setup() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        pushTextFieldsUp()
        hideKeyboardWhenTappedAround()
        createLabelConstraints()
        createLoginConstraints()
        createPasswordConstraints()
        createButtonConstrainsts()
        isEmailValid()
    }
    
    func isEmailValid() {
        let text = loginTextField.text ?? ""
        if !text.isEmpty {
            if text.contains("@") {
                loginTextField.backgroundColor = .systemGreen
            } else {
                loginTextField.backgroundColor = .systemRed
            }
        }
    }
    
    //MARK: - KeyBord Logic
    
    //"return" on keybord = keybord closing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    //tapped around = keybord closing
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //pushing textFields upper when its portrait orientation
    func pushTextFieldsUp() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { _ in
            if !UIDevice.current.orientation.isPortrait && self.view.frame.origin.y == 0{
                self.view.frame.origin.y = -60
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
            self.view.frame.origin.y = 0
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEmailValid()
    }
    
    

}


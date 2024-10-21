import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    struct Constants {
        static let labelFontSize: CGFloat = 40
        static let elementsCornerRadius: CGFloat = 20
        static let loginButtonSizeFont: CGFloat = 20
        static let errorLabelFontSize: CGFloat = 12
    }
    
    
    //MARK: - Fields
    private let label : UILabel = {
        let view = UILabel()
        view.text = "Sigma App"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: .init(Constants.labelFontSize))
        return view
    }()
    
    private let loginTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter E-mail..."
        view.layer.cornerRadius = Constants.elementsCornerRadius
        view.backgroundColor = .systemGray6
        view.borderStyle = .roundedRect
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter password..."
        view.layer.cornerRadius = Constants.elementsCornerRadius
        view.backgroundColor = .systemGray6
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        return view
    }()
    
    private let loginButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Login", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.titleLabel?.font = .systemFont(ofSize: .init(Constants.loginButtonSizeFont))
        view.layer.cornerRadius = Constants.elementsCornerRadius
        return view
    }()
    
    private let errorLabel: UILabel = {
        let view = UILabel()
        view.text = "Enter a valid E-mail. Example test@test.com"
        view.textColor = .systemRed
        view.textAlignment = .left
        view.font = .systemFont(ofSize: .init(Constants.errorLabelFontSize))
        view.isHidden = true
        return view
    }()
    
    //MARK: - Constraints
    private func createLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    private func createLoginConstraints() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginTextField)
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
    }
    
    private func createPasswordConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 35).isActive = true
    }
    
    private func createButtonConstrainsts() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginTextField.widthAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createErrorLabelConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorLabel)
        errorLabel.leftAnchor.constraint(equalTo: loginTextField.leftAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    //MARK: - Functions
    private func setup() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        pushTextFieldsUp()
        hideKeyboardWhenTappedAround()
        createLabelConstraints()
        createLoginConstraints()
        createPasswordConstraints()
        createButtonConstrainsts()
        createErrorLabelConstraints()
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    private func isEmailValid() -> Bool{
        let text = loginTextField.text ?? ""
        if !text.isEmpty {
            if text.contains("@") && text.contains(".com"){
                return true
            }
        }
        return false
    }
    
    @objc func login() {
        if isEmailValid() {
            errorLabel.isHidden = true
            let secondvc = SecondViewController()
            navigationController?.pushViewController(secondvc, animated: true)
        }
        else {
            loginTextField.backgroundColor = .lightRed
            errorLabel.isHidden = false
        }
    }
    
    //MARK: - KeyBord Logic
    
    //"return" on keybord = keybord closing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    //tapped around = keybord closing
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //pushing textFields upper when its portrait orientation
    private func pushTextFieldsUp() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { _ in
            if self.view.bounds.width > self.view.bounds.height && self.view.frame.origin.y == 0{
                print(self.view.bounds.width < self.view.bounds.height)
                self.view.frame.origin.y = -80
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
            self.view.frame.origin.y = 0
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isEmailValid() {
            loginTextField.backgroundColor = .lightGreen
        }
        else {
            loginTextField.backgroundColor = .lightRed
        }
    }
}


import UIKit

final class ViewController: UIViewController{

    private enum Constants {
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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setup()
        addConstraints()
        view.backgroundColor = .white
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

extension ViewController : UITextFieldDelegate  {
    private func addSubviews() {
        [
            label,
            loginTextField,
            passwordTextField,
            loginButton,
            errorLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setup() {
        pushTextFieldsUp()
        hideKeyboardWhenTappedAround()
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.backgroundColor = .white
    }
    
    private func isEmailValid() -> Bool{
        let text = loginTextField.text ?? ""
        guard !text.isEmpty else { return false }
        guard text.contains("@") && text.contains(".com") else { return false }
        return true
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
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        NSLayoutConstraint.activate([
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            loginTextField.heightAnchor.constraint(equalToConstant: 35),
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30)
        ])
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 35)
        ])
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: loginTextField.widthAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            errorLabel.leftAnchor.constraint(equalTo: loginTextField.leftAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10)
        ])
    }
}

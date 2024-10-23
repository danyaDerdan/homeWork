import UIKit

final class SecondViewController: UIViewController {

    private enum Constants {
        static let textLabelFontSizeConstant: CGFloat = 30
        static let labelTextEditFontSizeConstant: CGFloat = 20
        static let microFontSize : CGFloat = 15
    }
    
    //MARK: - Fields
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = .systemFont(ofSize: .init(Constants.textLabelFontSizeConstant))
        return label
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter text"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private lazy var labelTextEdit: UILabel = {
        let label = UILabel()
        label.text = "Edit text"
        label.font = .systemFont(ofSize: .init(Constants.labelTextEditFontSizeConstant))
        label.textAlignment = .left
        return label
    }()
    
    private lazy var switchButton: UISwitch = {
        let button = UISwitch()
        button.isOn = false
        return button
    }()
    
    private lazy var labelToSwitchButton: UILabel = {
        let label = UILabel()
        label.text = "Red text"
        label.font = .systemFont(ofSize: .init(Constants.microFontSize))
        label.textAlignment = .left
        return label
    }()
    
    private lazy var slider: UISlider = {
        let view = UISlider()
        view.minimumValue = Float(Constants.microFontSize)
        view.maximumValue = Float(Constants.textLabelFontSizeConstant)
        view.value = view.minimumValue
        return view
    }()
    
    private lazy var sliderLabel: UILabel = {
        let label = UILabel()
        label.text = "Font size"
        label.font = .systemFont(ofSize: .init(Constants.microFontSize))
        label.textAlignment = .left
        return label
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpConstraints()
        view.backgroundColor = .white
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    //MARK: - Funcs
    @objc func submit() {
        textLabel.text = "\(textField.text ?? "")"
        if switchButton.isOn {
            textLabel.textColor = .red
        }
        else {
            textLabel.textColor = .black
        }
        textLabel.font = UIFont.systemFont(ofSize: CGFloat(Int(slider.value)))
        print(slider.value)
    }
}

private extension SecondViewController{
    private func addSubviews() {
        [
            textLabel,
            textField,
            labelTextEdit,
            switchButton,
            labelToSwitchButton,
            slider,
            sliderLabel,
            submitButton
        ].forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
            ])
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            labelTextEdit.leftAnchor.constraint(equalTo: textField.leftAnchor),
            labelTextEdit.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        NSLayoutConstraint.activate([
            labelToSwitchButton.leftAnchor.constraint(equalTo: textField.leftAnchor),
            labelToSwitchButton.topAnchor.constraint(equalTo: labelTextEdit.bottomAnchor, constant: 30)
            ])
        NSLayoutConstraint.activate([
            switchButton.rightAnchor.constraint(equalTo: textField.rightAnchor),
            switchButton.centerYAnchor.constraint(equalTo: labelToSwitchButton.centerYAnchor),
            switchButton.widthAnchor.constraint(equalToConstant: 50),
            switchButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            sliderLabel.leftAnchor.constraint(equalTo: textField.leftAnchor),
            sliderLabel.topAnchor.constraint(equalTo: switchButton.bottomAnchor, constant: 30)
            ])
        NSLayoutConstraint.activate([
            slider.leftAnchor.constraint(equalTo: sliderLabel.rightAnchor, constant: 50),
            slider.rightAnchor.constraint(equalTo: textField.rightAnchor),
            slider.centerYAnchor.constraint(equalTo: sliderLabel.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}

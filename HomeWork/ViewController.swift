import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //MARK: - Fields
    private let label : UILabel = {
        let view = UILabel()
        view.text = "Sigma App"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: .init(40))
        return view
    }()
    
    //MARK: - Constraints
    func createLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    //MARK: - Functions
    func setup() {
        createLabelConstraints()
    }

}


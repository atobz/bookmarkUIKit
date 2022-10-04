import UIKit

class OpeningPage: UIViewController {
    
    lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = "Save all interesting links in one App"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    
    lazy var backgroundImage : UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "bookmarkBackground")
        backgroundImage.contentMode = .scaleToFill

        return backgroundImage
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Lets start collecting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        [backgroundImage, titleText, button].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false

        }
        
        view.addSubview(backgroundImage)
        view.addSubview(titleText)
        view.addSubview(button)
        
        
        let constraints = [
        
                           backgroundImage.topAnchor.constraint(equalTo:  view.topAnchor),
                           backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
                           backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
                           
                           titleText.widthAnchor.constraint(equalToConstant: 358),
                           titleText.heightAnchor.constraint(equalToConstant: 92),
                           titleText.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 30),
                           titleText.leftAnchor.constraint(equalTo: backgroundImage.leftAnchor, constant: 20),
                           titleText.bottomAnchor.constraint(equalTo: button.topAnchor, constant: 40),
                            
                           button.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -30),
                           button.leftAnchor.constraint(equalTo: backgroundImage.leftAnchor, constant: 20),
                           button.rightAnchor.constraint(equalTo: backgroundImage.rightAnchor, constant: -20),
                           button.heightAnchor.constraint(equalToConstant: 58)
                           
                     
                           ]
                    
      NSLayoutConstraint.activate(constraints)
        
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
       


        
        
    }
    
    @objc private func handleButton(){
        self.navigationController?.pushViewController(SecondPage(), animated: true)
        //self - обращение к самому себе (в этом случае ExampleViewController.navigationControleer?.pushViewController
        
        
    }


}



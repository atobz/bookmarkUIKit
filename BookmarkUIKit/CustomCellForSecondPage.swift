import UIKit
import SnapKit

//Создаем кастомную ячейку

class CustomCellForSecondPage: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    lazy var  linkLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var OpenURLButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "openImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(.init(handler: {_ in
            self.openURL()
            
        }), for: .touchUpInside)
    
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureVisualPlacementForCellParts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: LinkModel) {
        self.titleLabel.text = model.title
        self.linkLabel.text = model.link
    }
    
    
    func configureVisualPlacementForCellParts() {
        
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        
        self.contentView.addSubview(OpenURLButton)
        OpenURLButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(18)
        }
        OpenURLButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openURL)))
        
    }
    
    
    @objc func openURL() {
        guard let url = URL(string: "https://\(linkLabel.text!)") else{ return }
        UIApplication.shared.open(url)
        print("triggered URL openning")
    }
}


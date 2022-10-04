import UIKit
import SnapKit

class SecondPage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
  //  lazy var exampleLink : [LinkModel] = [LinkModel(title: "google", link: "www.google.com")]
    lazy var titleAndLinkArray : [LinkModel] = Storage.storedTitleAndLinkArray
    
    //-MARK: ---------------------------VISUALS -----------------------
    lazy var smallHeader: UILabel = {
        let label = UILabel()
        label.text = "Bookmark App"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = "Save your first bookmark"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Add Bookmark", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    
    
    
    
    
    
//-MARK: -----------------------------------------------------------
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
   
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.titleAndLinkArray.count
    }
    //-XMARK: Сколько rows надо создать для таблице
    
    
    //-XMARK: Asks the data source for a cell to insert in a particular location of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
                as? CustomCellForSecondPage else { return UITableViewCell() }
        //Создаем свою кастомную ячейку для таблицы, если не получилось верни нам дефолтную
        //Кастомная ячейчка - LinkTableViewCell (создали отдельный файл для нее)
        
        cell.configure(model: titleAndLinkArray[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            titleAndLinkArray.remove(at: indexPath.row)
            Storage.storedTitleAndLinkArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            showIfTableHaveValues()
        }
    }

//-MARK: -----------------------------------------------------------
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        tableView.register(CustomCellForSecondPage.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        [ titleText, button, smallHeader, tableView].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        view.addSubview(tableView)
        view.addSubview(titleText)
        view.addSubview(button)
        view.addSubview(smallHeader)
        
        
        let constraints = [
            
            titleText.widthAnchor.constraint(equalToConstant: 358),
            titleText.heightAnchor.constraint(equalToConstant: 92),
            titleText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            smallHeader.widthAnchor.constraint(equalToConstant: 358),
            smallHeader.heightAnchor.constraint(equalToConstant: 30),
            smallHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallHeader.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 58)
            
    
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(42)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        
    }
    
    private func showIfTableHaveValues(){
        if titleAndLinkArray.isEmpty{
            tableView.isHidden = true
            smallHeader.isHidden = false
            titleText.isHidden = false
        } else {
            tableView.isHidden = false
            smallHeader.isHidden = true
            titleText.isHidden = true
            
        }
    }
    
    @objc private func showAlert(){
        let alert = UIAlertController(
            title: "Sign in",
            message: "please sign in",
            preferredStyle: .alert)
        
        //alert[0]
        alert.addTextField { field in
            field.placeholder = "Enter the title of webpage"
            field.returnKeyType = .next
            field.keyboardType = .emailAddress
        }
        //alert[1]
        alert.addTextField { field in
            field.placeholder = "URL Link of a webpage"
            field.returnKeyType = .next
            field.keyboardType = .emailAddress
        }
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        alert.addAction(UIAlertAction(title: "Save the link", style: .default, handler:{ [weak alert] (_) in
            guard let enteredTitle = alert?.textFields?[0].text, enteredTitle != "" else { return}
            guard let enteredLink = alert?.textFields?[1].text, enteredLink != "" else { return}
 
            self.addTitleAndLinkToArray(title: enteredTitle, link: enteredLink)

        }))
        
        self.present(alert, animated: true)
    }
    
    
    
    
                
    
    
    private func addTitleAndLinkToArray(title: String, link: String){
        self.titleAndLinkArray.append(LinkModel(title: title, link: link))
        Storage.storedTitleAndLinkArray.append(LinkModel(title: title, link: link))
        self.tableView.reloadData()
        showIfTableHaveValues()
    }
    
}

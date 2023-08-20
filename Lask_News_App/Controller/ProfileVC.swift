//
//  ProfielVC.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//
import UIKit

class ProfileVC: UIViewController {
    
    var sectionNameArray = [ "Clapped Articls","Read Articls"]
    var sectionNameArray2 = [ "My Account", "Privasy Setting", "Ofline Reading", "About Us"]
    
    private let avatarImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "kingfisher")
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 60
        img.clipsToBounds = true
        return img
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = " King Fisher bird"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25, weight:  .semibold)
        label.numberOfLines = 2
        return label
    }()
    //  line UIview
    private let lineUIview: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayColor")
        return view
    }()
    //MARK: - UIStack Views
    private let avatarContenerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing  = 15
        stack.alignment  = .fill
        stack.distribution  = .fillProportionally
        return stack
    }()
    private let mainContenerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing  = 20
        stack.alignment  = .fill
        stack.distribution  = .fillProportionally
        return stack
    }()
    
    //MARK: - UIStackView of information about the user
    private let articleReadStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing  = 10
        stack.alignment  = .fill
        stack.distribution  = .fillProportionally
        return stack
    }()
    private let streakStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing  = 10
        stack.alignment  = .fill
        stack.distribution  = .fillProportionally
        return stack
    }()
    private let lavelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing  = 10
        stack.alignment  = .fill
        stack.distribution  = .fillProportionally
        return stack
    }()
    
    
    //MARK: -  AN UIStackView  FOR THE GOUP STACKS
    
    private let groupStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing  = 10
        stack.alignment  = .fill
        stack.distribution  = .fillProportionally
        return stack
    }()
    
    //MARK: - Collection Labels of information about the user
    private let articleRead: UILabel = {
        let l = UILabel()
        l.text = "Article Read"
        l.textColor = UIColor(named: "darkGray")
        l.font = UIFont.systemFont(ofSize: 15, weight: .light)
        l.textAlignment = .center
        return l
    }()
    
    private let streakLabel: UILabel = {
        let l = UILabel()
        l.text = "Streak"
        l.textColor = UIColor(named: "darkGray")
        l.font = UIFont.systemFont(ofSize: 15, weight: .light)
        l.textAlignment = .center
        return l
    }()
    //
    private let lavelLabel: UILabel = {
        let l = UILabel()
        l.text = "Level"
        l.textColor = UIColor(named: "darkGray")
        l.font = UIFont.systemFont(ofSize: 15, weight: .light)
        l.textAlignment = .center
        return l
    }()
    
    //MARK: - Collection score Labels of information about the user
    private let articleCountLable: UILabel = {
        let l = UILabel()
        l.text = "304"
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        l.textAlignment = .center
        return l
    }()
    
    private let streakCountLabel: UILabel = {
        let l = UILabel()
        l.text = "345 Read"
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        l.textAlignment = .center
        return l
    }()
    private let lavelCountLabel: UILabel = {
        let l = UILabel()
        l.text = "455"
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        l.textAlignment = .center
        return l
    }()
    let tableView: UITableView = {
        let t = UITableView()
        return t
    }()
    
    //MARK: -  override func viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelstoStack()
        setTableVeiw()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let readTitles = UserDefaults.standard.array(forKey: "read") as? [String] {
            articleCountLable.text = "\(readTitles.count)"
        } else {
            articleCountLable.text = "0"
        }
    }
    
    func setTableVeiw() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        view.addSubview( tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.top.equalTo(mainContenerStack.snp.bottom)
        }
    }
    
    func setLabelstoStack() {
        view.backgroundColor = .tertiarySystemBackground
        //aricle
        view.addSubview(mainContenerStack)
        
        mainContenerStack.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide)
            [ articleRead, articleCountLable].forEach { items in
                articleReadStack.addArrangedSubview(items)
            }
            [ streakLabel, streakCountLabel].forEach { items in
                streakStack.addArrangedSubview(items)
            }
            [ lavelLabel, lavelCountLabel].forEach { items in
                lavelStack.addArrangedSubview(items)
            }
            
            [articleReadStack, streakStack, lavelStack].forEach { stacks in
                groupStack.addArrangedSubview(stacks)
            }
            
            [avatarImage, nameLabel].forEach { item in
                avatarContenerStack.addArrangedSubview(item)
            }
            avatarImage.snp.makeConstraints { make in
                make.height.width.equalTo(120)
            }
            
            [ avatarContenerStack, groupStack, lineUIview].forEach { groupStack in
                mainContenerStack.addArrangedSubview(groupStack)
            }
            lineUIview.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.width.equalTo(view.frame.width - 30)
            }
        }
    }
}

extension ProfileVC: UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
     2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default: return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if indexPath.section == 0 {
            cell.textLabel?.text = sectionNameArray[indexPath.row]
        } else {
            cell.textLabel?.text = sectionNameArray2[indexPath.row]
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let title = UILabel()
         
        switch section {
        case 0: title.text = "Reading History"
        default:
            title.text = "Settings"
        }
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .black
        title.textAlignment = .left
        
        let contanerView = UIView()
        contanerView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: tableView.frame.width,
                                    height: 40)
        contanerView.addSubview( title)
        
        title.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview()
        }
        
        return contanerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let nav =  UINavigationController(rootViewController: ClappedArticlsVC())
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        default:
            let nav =  UINavigationController(rootViewController: ReadArticlVC())
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
    
    
}


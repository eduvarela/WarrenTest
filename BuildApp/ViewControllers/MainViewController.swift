//
//  MainViewController.swift
//  BuildApp
//
import UIKit

class MainViewController: UIViewController {
    let tableView: UITableView = UITableView()
    let loadingView: UIView = UIView()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "Objetivos"
        
        self.view.addSubview(tableView)
        self.view.addSubview(loadingView)
        self.loadingView.addSubview(activityIndicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ObjetivoTableViewCell.self, forCellReuseIdentifier: "ObjetivoCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 64.0
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        loadingView.isHidden = true
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        activityIndicator.style = .medium
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true
        
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceivedPortfolios(_:)), name: .didReceivedPortfolios, object: nil)
        ServiceManager.portfolios()
    }
    
    @objc func onDidReceivedPortfolios(_ notification:Notification) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
            }
        }
    }

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Application.shared.portfolios?.portfolios.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainViewController = MainViewController()
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjetivoCell", for: indexPath) as! ObjetivoTableViewCell
        if let objetivo = Application.shared.portfolios?.portfolios[indexPath.row]{
            cell.nameLabel.text = objetivo.name
            cell.totalLabel.text = "R$ \(DataManager.formatCurrency(value: objetivo.totalBalance))"
            cell.goalAmountLabel.text = "R$ \(DataManager.formatCurrency(value: objetivo.goalAmount ?? 0))"
            cell.goalDateLabel.text = DataManager.formatDate(dateString: objetivo.goalDate)
            DispatchQueue.main.async {
                cell.backgroundImageView.alpha = 0.4
                cell.backgroundImageView.image = ServiceManager.downloadImage(from: objetivo.background.thumb)
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}

//
//  ObjetivoDetalhesViewController.swift
//  BuildApp
//
import UIKit
class ObjetivoDetalhesViewController: UIViewController {
    var objetivoIndex: Int = 0
    let headerImageView: UIImageView = UIImageView()

    let nameTitleLabel: UILabel = UILabel()
    let totalTitleLabel: UILabel = UILabel()
    let goalAmountTitleLabel: UILabel = UILabel()
    let goalDateTitleLabel: UILabel = UILabel()

    let nameLabel: UILabel = UILabel()
    let totalLabel: UILabel = UILabel()
    let goalAmountLabel: UILabel = UILabel()
    let goalDateLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.view.addSubview(headerImageView)
        self.view.addSubview(nameTitleLabel)
        self.view.addSubview(nameLabel)
        self.view.addSubview(totalTitleLabel)
        self.view.addSubview(totalLabel)
        self.view.addSubview(goalAmountTitleLabel)
        self.view.addSubview(goalAmountLabel)
        self.view.addSubview(goalDateTitleLabel)
        self.view.addSubview(goalDateLabel)

        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        headerImageView.alpha = 0.3

        //Name
        nameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        nameTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        nameTitleLabel.text = "Objetivo"
        nameTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.nameTitleLabel.bottomAnchor, constant: 12).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true

        if let nameText = Application.shared.portfolios?.portfolios[objetivoIndex].name {
            self.title = nameText
            nameLabel.text = nameText
        }

        //Total
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTitleLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 16).isActive = true
        totalTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        totalTitleLabel.text = "Valor Total"
        totalTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.topAnchor.constraint(equalTo: self.totalTitleLabel.bottomAnchor, constant: 12).isActive = true
        totalLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true

        if let totalValue = Application.shared.portfolios?.portfolios[objetivoIndex].totalBalance {
            totalLabel.text = "R$ \(DataManager.formatCurrency(value: totalValue))"
        }
        
        //GoalAmount
        goalAmountTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        goalAmountTitleLabel.topAnchor.constraint(equalTo: self.totalLabel.bottomAnchor, constant: 16).isActive = true
        goalAmountTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        goalAmountTitleLabel.text = "Meta"
        goalAmountTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        goalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        goalAmountLabel.topAnchor.constraint(equalTo: self.goalAmountTitleLabel.bottomAnchor, constant: 12).isActive = true
        goalAmountLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true

        if let goalAmountValue = Application.shared.portfolios?.portfolios[objetivoIndex].goalAmount {
            goalAmountLabel.text = "R$ \(DataManager.formatCurrency(value: goalAmountValue))"
        }
        
        //GoalDate
        goalDateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        goalDateTitleLabel.topAnchor.constraint(equalTo: self.goalAmountLabel.bottomAnchor, constant: 16).isActive = true
        goalDateTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        goalDateTitleLabel.text = "Data Limite"
        goalDateTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        goalDateLabel.translatesAutoresizingMaskIntoConstraints = false
        goalDateLabel.topAnchor.constraint(equalTo: self.goalDateTitleLabel.bottomAnchor, constant: 12).isActive = true
        goalDateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true

        if let goalDateValue = Application.shared.portfolios?.portfolios[objetivoIndex].goalDate {
            goalDateLabel.text = DataManager.formatDate(dateString: goalDateValue)
        }


        if let backgroundUrl = Application.shared.portfolios?.portfolios[objetivoIndex].background.regular {
            headerImageView.image = ServiceManager.downloadImage(from: backgroundUrl)
        }

    }
}

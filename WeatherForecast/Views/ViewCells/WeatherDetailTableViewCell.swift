//
//  WeatherDetailTableViewCell.swift
//  WeatherForecast
//
//  Created by Maxim Kucherov on 05/12/2023.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

    let weekDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let iconPercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    private func setupViews() {
        let detailStackView = UIStackView(arrangedSubviews: [weekDayLabel, iconPercentLabel, tempLabel])
        detailStackView.axis = .horizontal
        detailStackView.distribution = .equalSpacing
        
        contentView.addSubview(detailStackView)
        
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            detailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

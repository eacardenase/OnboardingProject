//
//  DividerView.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/26/23.
//

import UIKit

class DividerView: UIView {
    
    // Properties
    
    let label = UILabel()
    let leftDivider = UIView()
    let rightDivider = UIView()
    
    // Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension DividerView {
    private func configureUI() {
        leftDivider.backgroundColor = UIColor(white: 1, alpha: 0.25)
        rightDivider.backgroundColor = UIColor(white: 1, alpha: 0.25)
        
        label.text = "OR"
        label.textColor = UIColor(white: 1, alpha: 0.87)
        label.font = UIFont.systemFont(ofSize: 14)
        
        leftDivider.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        rightDivider.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(leftDivider)
        addSubview(rightDivider)
                
        // label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        // leftDivider
        NSLayoutConstraint.activate([
            leftDivider.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            leftDivider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            leftDivider.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            leftDivider.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // rightDivider
        NSLayoutConstraint.activate([
            rightDivider.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            rightDivider.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            rightDivider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            rightDivider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

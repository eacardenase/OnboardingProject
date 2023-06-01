//
//  OnboardingController.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/31/23.
//

import UIKit
import PaperOnboarding

class OnboardingController: UIViewController {

    // MARK: - Properties

    private var onboardingItems = [OnboardingItemInfo]()
    private var onboardingView = PaperOnboarding()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureOnboardingDataSource()
    }
}

// MARK: - Helpers

extension OnboardingController {
    private func configureUI() {

        onboardingView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(onboardingView)

        // onboardingView
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureOnboardingDataSource() {
        let item1 = OnboardingItemInfo(informationImage:
                                       UIImage(named: "baseline_insert_chart_white_48pt")!.withRenderingMode(.alwaysOriginal),
                                       title: "Metrics", description: "Some description in here",
                                       pageIcon: UIImage(), color: .systemPurple, titleColor: .white,
                                       descriptionColor: .white, titleFont: UIFont.systemFont(ofSize: 24),
                                       descriptionFont: UIFont.systemFont(ofSize: 16))

        onboardingItems.append(item1)
        onboardingItems.append(item1)
        onboardingItems.append(item1)

        onboardingView.dataSource = self
        onboardingView.reloadInputViews()
    }
}

// MARK: - PaperOnboardingDataSource

extension OnboardingController: PaperOnboardingDataSource {
    func onboardingItemsCount() -> Int {
        return onboardingItems.count
    }

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return onboardingItems[index]
    }
}

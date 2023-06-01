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
    
    private let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(dismissOnboarding), for: .touchUpInside)
        
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.delegate = self

        configureUI()
        configureOnboardingDataSource()
    }
    
    // only works if not inside navigation bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Helpers

extension OnboardingController {
    private func configureUI() {

        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        
        getStartedButton.alpha = 0

        view.addSubview(onboardingView)
        view.addSubview(getStartedButton)

        // onboardingView
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // getStartedButton
        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -128)
        ])
    }

    private func configureOnboardingDataSource() {
        let metricsItem = OnboardingItemInfo(informationImage:
                                       UIImage(named: "baseline_insert_chart_white_48pt")!.withRenderingMode(.alwaysOriginal),
                                       title: K.Onboarding.MSG_METRICS, description: K.Onboarding.MSG_ONBOARDING_METRICS,
                                       pageIcon: UIImage(), color: .systemPurple, titleColor: .white,
                                       descriptionColor: .white, titleFont: UIFont.systemFont(ofSize: 24),
                                       descriptionFont: UIFont.systemFont(ofSize: 16))

        let dashboardItem = OnboardingItemInfo(informationImage:
                                       UIImage(named: "baseline_dashboard_white_48pt")!.withRenderingMode(.alwaysOriginal),
                                       title: K.Onboarding.MSG_DASHBOARD, description: K.Onboarding.MSG_ONBOARDING_DASHBOARD,
                                       pageIcon: UIImage(), color: .systemBlue, titleColor: .white,
                                       descriptionColor: .white, titleFont: UIFont.systemFont(ofSize: 24),
                                       descriptionFont: UIFont.systemFont(ofSize: 16))

        let notificationsItem = OnboardingItemInfo(informationImage:
                                       UIImage(named: "baseline_notifications_active_white_48pt")!.withRenderingMode(.alwaysOriginal),
                                       title: K.Onboarding.MSG_NOTIFICATIONS, description: K.Onboarding.MSG_ONBOARDING_NOTIFICATIONS,
                                       pageIcon: UIImage(), color: .systemPink, titleColor: .white,
                                       descriptionColor: .white, titleFont: UIFont.systemFont(ofSize: 24),
                                       descriptionFont: UIFont.systemFont(ofSize: 16))

        onboardingItems.append(metricsItem)
        onboardingItems.append(dashboardItem)
        onboardingItems.append(notificationsItem)

        onboardingView.dataSource = self
        onboardingView.reloadInputViews()
    }
    
    private func animateGetStartedButton(_ shouldShow: Bool) {
        let alpha: CGFloat = shouldShow ? 1 : 0
        
        UIView.animate(withDuration: 0.5) {
            self.getStartedButton.alpha = alpha
        }
    }
}

// MARK: - Actions

extension OnboardingController {
    @objc private func dismissOnboarding(_ sender: UIButton) -> Void {
        print("DEBUG: Handle dismiss onboarding")
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

// MARK: - PaperOnboardingDelegate

extension OnboardingController: PaperOnboardingDelegate {
    func onboardingDidTransitonToIndex(_ index: Int) {
        let viewModel = OnboardingViewModel(itemsCount: onboardingItems.count)
        let shouldShow = viewModel.shouldShowGetStartedButton(for: index)
        
        animateGetStartedButton(shouldShow)
    }
}

//
//  OnboardingViewModel.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/31/23.
//

import Foundation

struct OnboardingViewModel {
    
    private let itemsCount: Int
    
    init(itemsCount: Int) {
        self.itemsCount = itemsCount
    }
    
    func shouldShowGetStartedButton(for index: Int) -> Bool {
        return index == itemsCount - 1 ? true : false
    }
}

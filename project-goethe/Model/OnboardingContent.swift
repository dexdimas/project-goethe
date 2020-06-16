//
//  OnboardingContent.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 12/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import Foundation

struct OnboardingContent {
    let pages: [OnboardingPage] = [
        OnboardingPage(title: "Extract colors from your surrounding", image: #imageLiteral(resourceName: "background-onboarding1"), description: "Get details from the live camera, or from the photo picker", animationName: nil),
        OnboardingPage(title: "Discover collections of color harmony", image: #imageLiteral(resourceName: "background-onboarding2"), description: "Save tints from across the app, imports tints from the world ", animationName: nil),
        OnboardingPage(title: "Create color scheme that match your taste", image: #imageLiteral(resourceName: "background-onboarding3"), description: "More than red, green, blue, all the details in one place, RGB, HEX, CMYK, and related palletes", animationName: nil)]
}

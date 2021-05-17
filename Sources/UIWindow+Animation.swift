//
//  UIWindow+Animation.swift
//  UIKitAnimations
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension UIWindow {


	/// Updates the root view controller with an optional cross fade transition
	///
	/// - Parameters:
	///		- viewController: the new root view controller to set
	///		- animated: **optional** if true, the window will change with a transition. defaults to true
	///		- duration: **optional** the duration of the transition, defaults to 0.35s
	///		- options: **optional** the options for the transition, defaults to cross disolve
	///		- completion: **optional** the completion block to call if transition is finished, defaults to nil
	func setRootViewController(_ viewController: UIViewController,
							   animated: Bool = true,
							   duration: TimeInterval = 0.35,
							   options: UIView.AnimationOptions = [.allowAnimatedContent, .allowUserInteraction, .beginFromCurrentState, .transitionCrossDissolve],
							   completion: ((Bool) -> Void)? = nil) {
		guard rootViewController !== viewController else { return }

		self.performTransitionIfNeeded(animated: animated, duration: duration, delay: 0, options: options, animations: {
			self.rootViewController = viewController
		}, completion: completion)
	}

}

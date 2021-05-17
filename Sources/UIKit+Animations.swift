//
//  UIKit+Animations.swift
//  UIKitAnimations
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension UIView {
	/// Performs a transition animation in this view
	///
	/// - Parameters:
	///		- duration: **optional** the duration of the transition, defaults to 0.25
	///		- delay: **optional**  the animation delay, defaults to 0
	///		- options: **optional** the options for the animation, defaults to `.transitionCrossDissolve`
	///		- animations: the updates to apply for the transition
	///		- completion: **optional** the completion handler to call, defaults to nil
	func performTransition(duration: TimeInterval = 0.25,
						   delay: TimeInterval = 0,
						   options: UIView.AnimationOptions = [.beginFromCurrentState, .allowAnimatedContent, .allowUserInteraction, .transitionCrossDissolve],
						   animations: @escaping () -> Void,
						   completion: ((Bool) -> Void)? = nil) {
		UIView.transition(with: self, duration: duration, options: options, animations: animations, completion: completion)
	}

	/// Performs a transition animation if animated == true
	///
	/// - Parameters:
	/// 	- animated: if true, the updates will be animated, otherwise they will not be animation
	///		- duration: **optional** the duration of the transition, defaults to 0.25
	///		- delay: **optional**  the animation delay, defaults to 0
	///		- options: **optional** the options for the animation, defaults to `.transitionCrossDissolve`
	///		- animations: the updates to apply for the transition
	///		- completion: **optional** the completion handler to call, defaults to nil
	func performTransitionIfNeeded(animated: Bool,
								   duration: TimeInterval = 0.25,
								   delay: TimeInterval = 0,
								   options: UIView.AnimationOptions = [.beginFromCurrentState, .allowAnimatedContent, .allowUserInteraction, .transitionCrossDissolve],
								   animations: @escaping() -> Void,
								   completion: ((Bool) -> Void)? = nil) {
		if animated == true {
			performTransition(duration: duration, delay: delay, options: options, animations: animations, completion: completion)
		} else {
			animations()
			completion?(true)
		}
	}

	/// Performs a transition animation if animated == true
	///
	/// - Parameters:
	/// 	- animated: if true, the updates will be animated, otherwise they will not be animation
	///		- duration: **optional** the duration of the transition, defaults to 0.25
	///		- delay: **optional**  the animation delay, defaults to 0
	///		- options: **optional** the options for the animation, defaults to `.beginFromCurrentState`
	///		- animations: the updates to apply for the transition
	///		- completion: **optional** the completion handler to call, defaults to nil
	static func performAnimationsIfNeeded(animated: Bool,
										  duration: TimeInterval = 0.25,
										  delay: TimeInterval = 0,
										  options: UIView.AnimationOptions = [.beginFromCurrentState, .allowAnimatedContent, .allowUserInteraction],
										  animations: @escaping () -> Void,
										  completion: ((Bool) -> Void)? = nil) {
		if animated == true {
			UIView.animate(withDuration: duration, delay: delay, options: [.beginFromCurrentState, .allowUserInteraction], animations: animations, completion: completion)
		} else {
			animations()
			completion?(true)
		}
	}
}

public extension UIView {

	/// Does a shake animation of a view, usually to indicate an error
	///
	/// - Parameters:
	/// 	- duration: **optional** the shake duration, defaults to 0.6s
	///		- delay: **optional** the delay before the animation starts, defaults to 0
	///		- completion: **optional** the block to call when the animation ends, defaults to nil
	func shake(duration: TimeInterval = 0.6, delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
		UINotificationFeedbackGenerator().notificationOccurred(.error)

		UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
			UIView.addKeyframe(withRelativeStartTime: 0.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: -10, y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 1.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: +10, y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 2.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: -10, y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 3.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: +10, y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 5.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: -5,  y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 6.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: +5,  y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 7.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: -2,  y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 8.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: +2,  y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 9.0/9.0, relativeDuration: 0/9.0, animations: {self.transform = .identity})
		}, completion: completion)
	}

	/// Does a shake animation of a view together with error haptic feedback, usually to indicate an error
	///
	/// - Parameters:
	/// 	- duration: **optional** the shake duration, defaults to 0.6s
	///		- delay: **optional** the delay before the animation starts, defaults to 0
	///		- completion: **optional** the block to call when the animation ends, defaults to nil
	func shakeWithHapticErrorFeedback(duration: TimeInterval = 0.6, delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
		UINotificationFeedbackGenerator().notificationOccurred(.error)
		shake(duration: duration, delay: delay, completion: completion)
	}
}


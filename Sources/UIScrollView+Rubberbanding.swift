//
//  UIScrollView+Rubberbanding.swift
//  Demo
//
//  Created by Andreas Verhoeven on 16/11/2021.
//

import UIKit

extension UIScrollView {
	/// Calculates the exponential decay duration for a given velocity and deceleration
	///
	/// - Parameters:
	/// 	- velocity: the velocity of the swipe
	/// 	- deceleration: the deceleration rate
	/// - Returns: the duration needed for the exponential decay of a scroll
	private static func calculateExponentialDecayDuration(velocity: CGFloat, deceleration: CGFloat) -> CGFloat {
		let tresholdPoint = CGFloat(1)
		let tresholdSpeed = CGFloat(5) // units/s
		
		// velocity * deceleration^duration = treshold
		// deceleration^duration = treshold / velocity
		// duration = log_deceleration(treshold / velocity)
		// duration = log(treshold / velocity) / log(deceleration)
		let velocityInMilliseconds = velocity / 1000
		let treshold = (tresholdPoint * tresholdSpeed) / 1000 // to milliseconds
		let duration = log(abs(treshold / velocityInMilliseconds)) / log(deceleration)
		if duration.isNaN || duration < 0 {
			return 0
		} else {
			return duration / 1000 // in seconds again
		}
	}

	/// Calculate the distance for the exponential decay of a scroll view swipe
	///
	/// - Parameters:
	/// 	- time: the time we are at
	/// 	- velocity: the velocity of the swipe
	/// 	- deceleration: the deceleration rate
	/// - Returns: the distance the scrollview would scroll after a swipe with the given velocity
	private static func calculateExponentialDecayValueDistance(at time: CGFloat, velocity: CGFloat, deceleration: CGFloat) -> CGFloat {
		let timeInMilliseconds = time * 1000
		let velocityInMilliseconds = velocity / 1000
		
		// v(time) = velocity * deceleration^time
		// distance = INT[ v(time) ]
		// distance = INT [velocity * deceleration^time]
		// distance = velocity * INT[deceleration^time]
		// distance = velocity * deceleration^time / ln(deceleration) + C
		// distance(0) = 0 = velocity * deceleration^0 / ln(deceleration) + C
		// C =  - velocity / ln(deceleration)
		// distance = velocity * deceleration^time / ln(deceleration) - velocity/ln(deceleration)
		// distance = (deceleration^time - 1) * velocity / ln(deceleration)
		return (pow(deceleration, timeInMilliseconds) - 1) * velocityInMilliseconds / log(deceleration)
	}
	
	/// Calculates the end value for a scrollview's momentum swipe
	///
	/// - Parameters:
	/// 	- velocity: the velocity of the swipe
	/// 	- deceleration: the deceleration rate
	/// 	- startValue: the startValue of the scroll view
	/// - Returns: the end value of a swipe in a scrollview with a given velocity and decelration
	public static func calculateMomentumEndValue(velocity: CGFloat, deceleration: CGFloat, startValue: CGFloat) -> CGFloat {
		let duration = calculateExponentialDecayDuration(velocity: velocity, deceleration: deceleration)
		let distance = calculateExponentialDecayValueDistance(at: duration, velocity: velocity, deceleration: deceleration)
		return startValue + distance
	}
	
	/// Applies the rubber banding effect for a given value, with minimum and maximum values and the given resistance. E.g, if the user drags to -100, we should rubber band to
	///  a value smaller than that.
	///
	/// - Parameters:
	/// 	- value: value we are currently at
	/// 	- minimum: the minimum value we can be at
	/// 	- maximum: the maximum value we can be at
	/// 	- resistance: **optional** how much the rubber band should resist extending, defaults to 0.55 (which is UIScrollView's default)
	/// - Returns: the value we should "scroll" to
	public static func applyRubberBandEffect(for value: CGFloat, minimum: CGFloat, maximum: CGFloat, resistance: CGFloat = 0.55) -> CGFloat {
		// * x = distance from the edge
		// * c = constant value, UIScrollView uses 0.55
		// * d = dimension, either width or height
		// b = (1.0 – (1.0 / ((x * c / d) + 1.0))) * d
		if value < minimum {
			let offset = minimum - value
			return minimum - (CGFloat(1.0) - (CGFloat(1.0) / ((offset * resistance / max(CGFloat(1.0), maximum)) + CGFloat(1.0)))) * maximum
		} else if value > maximum {
			let offset = value - maximum
			return maximum + (CGFloat(1.0) - (CGFloat(1.0) / ((offset * resistance / max(CGFloat(1.0), maximum)) + CGFloat(1.0)))) * maximum
		} else {
			return value
		}
	}
}





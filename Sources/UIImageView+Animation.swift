//
//  UIImageView+Animation.swift
//  UIKitAnimations
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension UIImageView {
	/// Sets an image with a cross fade animation if animated == true
	///
	/// - Parameters:
	///		- image: the new image to set
	///		- animated: if true, the image will be set with a cross fade animation taking 0.25s
	func setImage(_ image: UIImage?, animated: Bool = false) {
		guard self.image != image else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setImage(image, animated: false)
			}
		}

		self.image = image
	}

	/// Sets an image and tintColor with a cross fade animation if animated == true
	///
	/// - Parameters:
	///		- image: the new image to set
	///		- tintColor: the new tint color to set
	///		- animated: if true, the image will be set with a cross fade animation taking 0.25s
	func setImage(_ image: UIImage?, tintColor: UIColor?, animated: Bool = false) {
		guard self.image != image || self.tintColor != tintColor else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setImage(image, tintColor: tintColor, animated: false)

			}
		}

		self.image = image
		self.tintColor = tintColor
	}
}

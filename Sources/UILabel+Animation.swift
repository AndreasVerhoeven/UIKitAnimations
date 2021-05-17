//
//  UILabel+Animation.swift
//  UIKitAnimations
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension UILabel {

	/// Sets this label's text, optionally with a crossfade animation
	///
	/// - Parameters:
	///		- text: the new text to set
	///		- animated: if true, the text will be animated using a crossfade
	func setText(_ text: String?, animated: Bool = false) {
		guard self.text != text else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setText(text, animated: false)
			}
		}

		self.text = text
	}

	/// Sets this label's attributedText, optionally with a crossfade animation
	///
	/// - Parameters:
	///		- attributedText: the new attributedText to set
	///		- animated: if true, the text will be animated using a crossfade
	func setAttributedText(_ attributedText: NSAttributedString?, animated: Bool = false) {
		guard self.attributedText != attributedText else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setAttributedText(attributedText, animated: false)
			}
		}

		self.attributedText = attributedText
	}

	/// Sets this label's text and color, optionally with a crossfade animation
	///
	/// - Parameters:
	///		- text: the new text to set
	///		- textColor: the new text color to set
	///		- animated: if true, the text & color will be animated using a crossfade
	func setText(_ text: String?, textColor: UIColor?, animated: Bool = false) {
		guard self.text != text || self.textColor != textColor else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setText(text, textColor: textColor, animated: false)
			}
		}

		self.text = text
		self.textColor = textColor
	}

	/// Sets this label's textColor, optionally with a crossfade animation
	///
	/// - Parameters:
	///		- textColor: the new text color to set
	///		- animated: if true, the color will be animated using a crossfade
	func setTextColor(_ textColor: UIColor?, animated: Bool = false) {
		guard self.textColor != textColor else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setTextColor(textColor, animated: false)
			}
		}
		self.textColor = textColor
	}
}

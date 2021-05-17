//
//  ViewController.swift
//  Demo
//
//  Created by Andreas Verhoeven on 16/05/2021.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		label.frame = CGRect(origin: .zero, size: view.bounds.size)
		label.text = "Label 1"
		label.numberOfLines = 0
		label.textAlignment = .center
		view.addSubview(label)

		var counter = 0
		let displayLink = DisplayLink.started {
			counter += 1
			if counter % 30 == 0 {
				print("frame #\(counter)")
			}
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			label.setText("Other text", animated: true)
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				label.setText("Even more text, now in red", textColor: .red, animated: true)

				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					// signal that something went wrong
					label.shakeWithHapticErrorFeedback()

					DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
						// transitions the changes in the whole view
						let shouldAnimate = true
						self.view.performTransitionIfNeeded(animated: shouldAnimate) {
							label.textColor = .label
							self.view.overrideUserInterfaceStyle = .dark

							DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
								self.view.window?.setRootViewController(OtherViewController())
								displayLink.stop()
							}
						}
					}
				}
			}
		}
	}
}


class OtherViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .green
	}
}

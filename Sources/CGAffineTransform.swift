//
//  CGAffineTransform.swift
//  UIKitAnimations
//
//  Created by Andreas Verhoeven on 20/02/2022.
//

import UIKit

extension CGAffineTransform {
	/// Creates a transform that transforms the `from` rectangle to the `to` rectangle
	///
	///  - Parameters:
	///  	- from: the rectangle we want to apply the transform to
	///  	- to: the rectangle we should end up after applying the transform to `from`
	public init(from: CGRect, to: CGRect) {
		let scaleX = from.width != 0 ? to.width / from.width : 0
		let scaleY = from.height != 0 ? to.height / from.height : 0
		
		let translateX = to.midX - from.midX
		let translateY = to.midY - from.midY
		
		self = CGAffineTransform(translationX: translateX, y: translateY).scaledBy(x: scaleX, y: scaleY)
	}
	
	/// Creates a transform that transforms the `from` size to the `to` size
	///
	///  - Parameters:
	///  	- from: the size we want to apply the transform to
	///  	- to: the size we should end up after applying the transform to `from`
	public init(scaledFrom from: CGSize, to: CGSize) {
		let scaleX = from.width != 0 ? to.width / from.width : 0
		let scaleY = from.height != 0 ? to.height / from.height : 0
		self = CGAffineTransform(scaleX: scaleX, y: scaleY)
	}
	
	/// A transform that scaled by the given width and height
	public init(scaledTo size: CGSize) {
		self = CGAffineTransform(scaleX: size.width, y: size.height)
	}
	
	/// A transform with the same x and y scale
	public init(scale: CGFloat) {
		self.init(scaleX: scale, y: scale)
	}
	
	/// defines the direction of rotation
	public enum RotationDirection {
		case clockwise
		case counterClockwise
	}
	
	/// Creates a transform for a specific rotation in **degrees** (instead of radions). Also has a direction option, that defaults to clockwise.
	///
	///  - Parameters:
	///  	- degrees: the rotation angle in degrees, so from 0 to 360
	///		- direction: the direction of rotation, defaults to `.clockwise`.
	public init(rotationAngleInDegrees degrees: CGFloat, direction: RotationDirection = .clockwise) {
		let radians = degrees * .pi / 180
		self = CGAffineTransform(rotationAngle: radians * direction.multiplicationFactor)
	}
	
	
	/// A transform that translates to the given offset
	public init(translation offset: CGPoint) {
		self.init(translationX: offset.x, y: offset.y)
	}
	
	/// Returns this transform, but applied around an offset from the current point
	///
	/// - Parameters:
	/// 	- offset: the offset to apply this transform to
	///
	/// - Returns: a new transform that is applied around the given offset
	public func appliedAroundOffset(_ offset: CGPoint) -> CGAffineTransform {
		let toPointTransform = CGAffineTransform(translationX: offset.x, y: offset.y)
		let fromPointTransform = CGAffineTransform(translationX: -offset.x, y: -offset.y)
		return fromPointTransform.concatenating(self.concatenating(toPointTransform))
	}
	
	/// Returns this transform, but applied around an point in a rect with a given size and a given anchorPoint
	///
	/// - Parameters:
	/// 	- offset: the point to apply this transform to
	/// 	- size: the size to apply the anchorPoint to
	/// 	- anchorPoint: **optional** defaults to the center, the relative anchor point that the transform normally applies to
	///
	/// - Returns: a new transform that is applied around the given point
	public func appliedAround(_ point: CGPoint, size: CGSize, anchorPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)) -> CGAffineTransform {
		let currentPoint = CGPoint(x: anchorPoint.x * size.width, y: anchorPoint.y * size.height)
		let offset = CGPoint(x: point.x - currentPoint.x, y: point.y - currentPoint.y)
		return appliedAroundOffset(offset)
	}
	
	/// Returns this transform, but applied around an point in a given view
	///
	/// - Parameters:
	/// 	- offset: the point to apply this transform to
	/// 	- view: the view to base the transform on
	///
	/// - Returns: a new transform that is applied around the given point
	public func appliedAround(_ point: CGPoint, in view: UIView) -> CGAffineTransform {
		return appliedAround(point, size: view.bounds.size, anchorPoint: view.layer.anchorPoint)
	}
}

extension UIView {
	/// Sets a transform around a given point. Bu default, UIView transforms are applied to the point descrived by the anchorPoint.
	/// If you want to, for example, scale from a different point, use this method.
	///
	/// - Parameters:
	/// 	- transform: the transform to apply
	/// 	- point: the point to apply the transform around
	public func setTransform(_ transform: CGAffineTransform, around point: CGPoint) {
		self.transform = transform.appliedAround(point, in: self)
	}
}

extension CGAffineTransform.RotationDirection {
	/// internal helper to get the multiplicationFactor for a given rotation direction
	internal var multiplicationFactor: CGFloat {
		switch self {
			case .clockwise: return 1
			case .counterClockwise: return -1
		}
	}
}

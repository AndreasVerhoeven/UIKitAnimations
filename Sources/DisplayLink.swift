//
//  DisplayLink.swift
//  Demo
//
//  Created by Andreas Verhoeven on 18/05/2021.
//

import UIKit

/// A CADisplayLink wrapper that doesn't get retained and thus stops
/// the display link from firing if this instance is deallocated.
/// Also takes a callback block, instead of a selector.
public class DisplayLink: NSObject {

	public typealias Callback = () -> Void

	/// the callback to fire if the display link runs
	public var callback: Callback? {
		get { internalHandler.callback }
		set { internalHandler.callback = newValue }
	}


	/// the underlying CADisplayLink
	public lazy var caDisplayLink = CADisplayLink(target: internalHandler, selector: #selector(internalHandler.displayLinkFired(_:)))

	/// true if the display link has been started
	public private(set) var isStarted = false

	/// stops the display link from firing if paused
	public var isPaused: Bool {
		get { caDisplayLink.isPaused }
		set { caDisplayLink.isPaused  = newValue }
	}

	/// Creates an instance with a callback, will not be started
	///
	/// - Parameters:
	///		- callback: the callback to call
	public convenience init(callback: @escaping Callback) {
		self.init()
		self.callback = callback
	}

	/// Creates a started display link with a given callback
	///
	/// - Parameters:
	///		- callback: the callback to call
	///		- runloop: **optional** the runloop to start in, defaults to `.main`
	///		- mode: **optional** the mode to start in, defaults to `.common`
	/// - Returns: a started display link
	static func started(with callback: @escaping Callback, in runloop: RunLoop = .main, mode: RunLoop.Mode = .common) -> DisplayLink {
		let displayLink = DisplayLink(callback: callback)
		displayLink.start(in: runloop, mode: mode)
		return displayLink
	}

	deinit {
		stop()
	}

	/// Starts the display link. Won't do anything if already started.
	///
	/// - Parameters:
	///		- callback: the callback to call
	///		- runloop: **optional** the runloop to start in, defaults to `.main`
	///		- mode: **optional** the mode to start in, defaults to `.common`
	public func start(in runloop: RunLoop = .main, mode: RunLoop.Mode = .common) {
		guard isStarted == false else { return }
		isStarted = true
		caDisplayLink.add(to: runloop, forMode: mode)
	}

	/// Stops the display link. Won't do anything if already stopped.
	public func stop() {
		guard isStarted == true else { return }
		isStarted = false
		caDisplayLink.invalidate()
	}

	// MARK: - Private

	// This is the internal handler that handles our callback: it's a separate object, so that the CADisplayLink doesn't retain
	// our own object
	private class InternalHandler: NSObject {
		var callback: Callback?
		@objc func displayLinkFired(_ sender: CADisplayLink) {
			callback?()
		}
	}
	private var internalHandler = InternalHandler()
}

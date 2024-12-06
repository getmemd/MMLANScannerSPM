// The Swift Programming Language
// https://docs.swift.org/swift-book

import MMLanScanInternal

public struct LanDevice {
    public var hostname: String?
    public var ipAddress: String
    public var macAddress: String?
    public var subnetMask: String?
    public var brand: String?
    public var isLocalDevice: Bool
    
    fileprivate init(device: MMDevice) {
        self.hostname = device.hostname
        self.ipAddress = device.ipAddress
        self.macAddress = device.macAddress
        self.subnetMask = device.subnetMask
        self.brand = device.brand
        self.isLocalDevice = device.isLocalDevice
    }
}

public protocol LanScannerDelegate: AnyObject {
    func lanScanDidFindNewDevice(_ device: LanDevice)
    func lanScanDidFinishScanning(with status: LanScannerStatus)
    func lanScanDidFailedToScan()
    func lanScanDidUpdateProgress(_ progress: Float, overall: Int)
}

public enum LanScannerStatus {
    case finished
    case cancelled
    
    init(from status: MMLanScannerStatus) {
        switch status {
        case MMLanScannerStatusFinished:
            self = .finished
        case MMLanScannerStatusCancelled:
            self = .cancelled
        default:
            self = .cancelled
        }
    }
}

public class LanScanner: NSObject {
    // MARK: - Properties

    public var scanner: MMLANScanner?
    public weak var delegate: LanScannerDelegate?

    // MARK: - Init

    public init(delegate: LanScannerDelegate?) {
        self.delegate = delegate
    }

    // MARK: - Methods

    public func stop() {
        scanner?.stop()
    }

    public func start() {
        scanner?.stop()
        scanner = MMLANScanner(delegate: self)
        scanner?.start()
    }
}

// MARK: - MMLANScannerDelegate

extension LanScanner: MMLANScannerDelegate {
    public func lanScanDidFindNewDevice(_ device: MMDevice!) {
        delegate?.lanScanDidFindNewDevice(.init(device: device))
    }

    public func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        delegate?.lanScanDidFinishScanning(with: .init(from: status))
    }

    public func lanScanDidFailedToScan() {
        delegate?.lanScanDidFailedToScan()
    }
    
    public func lanScanProgressPinged(_ pingedHosts: Float, from overallHosts: Int) {
        delegate?.lanScanDidUpdateProgress(pingedHosts, overall: overallHosts)
    }
}

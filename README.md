# MMLanScan

**MMLanScan** is a library for scanning local networks and discovering all connected devices.  
Originally created by [Mavris](https://github.com/mavris/MMLanScan) and distributed via CocoaPods, this fork has been adapted to work seamlessly with the Swift Package Manager (SPM).

## Features

- Identify all devices connected to the local network (LAN)
- Retrieve both IP and MAC addresses
- Determine device vendors by MAC address
- Simple and intuitive API

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/getmemd/MMLanScan.git", from: "1.0.0")
]
```

## Example Usage

Below is an example of how to integrate `LanScanner` in a view controller:

```swift
import UIKit
import MMLanScan // Make sure MMLanScan is added via SPM and imported

class ViewController: UIViewController {
    private var lanScanner: LanScanner?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the scanner, passing self as the delegate
        lanScanner = LanScanner(delegate: self)
    }
    
    @IBAction func startScanning(_ sender: Any) {
        // Start the LAN scan
        lanScanner?.start()
    }
    
    @IBAction func stopScanning(_ sender: Any) {
        // Stop the LAN scan
        lanScanner?.stop()
    }
}

// MARK: - LanScannerDelegate

extension ViewController: LanScannerDelegate {
    func lanScanDidFindNewDevice(_ device: LanDevice) {
        print("Found device: IP=\(device.ipAddress), MAC=\(device.macAddress ?? "unknown"), Hostname=\(device.hostname ?? "unknown")")
    }

    func lanScanDidFinishScanning(with status: LanScannerStatus) {
        switch status {
        case .finished:
            print("Scanning finished successfully.")
        case .cancelled:
            print("Scanning was cancelled or interrupted.")
        }
    }

    func lanScanDidFailedToScan() {
        print("Failed to perform LAN scan.")
    }

    func lanScanDidUpdateProgress(_ progress: Float, overall: Int) {
        let percentage = Int(progress / Float(overall) * 100)
        print("Progress: \(percentage)% (\(Int(progress)) of \(overall))")
    }
}
```

What’s happening in this example:
-	We create an instance of LanScanner, assigning self as its delegate.
-	Calling start() begins scanning for devices on the local network.
-	As devices are found, lanScanDidFindNewDevice(_:) is triggered.
-	When scanning completes or is cancelled, lanScanDidFinishScanning(with:) is called.
-	Any errors that occur during scanning trigger lanScanDidFailedToScan().
-	lanScanDidUpdateProgress(_:overall:) is invoked periodically to indicate scan progress.


## License

This project is released under the MIT License. See LICENSE for details.

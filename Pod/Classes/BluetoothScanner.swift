//
//  BluetoothScanner.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//
//

import CoreBluetooth

public final class BluetoothScanner: NSObject
{
  private var centralManager:CBCentralManager
  private let centralManagerDelegate = CentralManagerDelegate()
  private let centralManagerQueue = dispatch_queue_create(
    "com.boutfitness.concept2.bluetooth.central",
    DISPATCH_QUEUE_CONCURRENT
  )
  
  @available(iOS 9.0, *)
  var isScanningForPerformanceMonitors:Bool {
    get {
      return centralManager.isScanning
    }
  }
  
  override public init() {
    centralManager = CBCentralManager(delegate: centralManagerDelegate,
      queue: centralManagerQueue)
    
    super.init()
  }
  
  public func scanForPerformanceMonitors() {
    centralManager.scanForPeripheralsWithServices([Service.DeviceDiscovery.UUID],
      options: nil)
  }
  
  public func stopScanningForPerformanceMonitors() {
    centralManager.stopScan()
  }
}
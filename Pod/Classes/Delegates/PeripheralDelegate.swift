//
//  PeripheralDelegate.swift
//  Pods
//
//  Created by Jesse Curry on 9/30/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

final class PeripheralDelegate: NSObject, CBPeripheralDelegate {
  weak var performanceMonitor:PerformanceMonitor?
  
  // MARK: Services
    private func peripheral(peripheral: CBPeripheral,
    didDiscoverServices
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverServices:")
      peripheral.services?.forEach({ (service:CBService) -> () in
        print("\t* \(service.description)")

        if let svc = Service(uuid: service.uuid) {
            peripheral.discoverCharacteristics(svc.characteristicUUIDs,
                                               for:  service)
        }
      })
  }
  
    private func peripheral(peripheral: CBPeripheral,
    didDiscoverIncludedServicesForService
    service: CBService,
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverIncludedServicesForService")
  }
  
    func peripheral(_ peripheral: CBPeripheral,
    didModifyServices
    invalidatedServices: [CBService]) {
      print("[PerformanceMonitor]didModifyServices")
  }
  
  // MARK: Characteristics
    private func peripheral(peripheral: CBPeripheral,
    didDiscoverCharacteristicsForService
    service: CBService,
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverCharacteristicsForService")
      service.characteristics?.forEach({ (characteristic:CBCharacteristic) -> () in
        peripheral.setNotifyValue(true, for: characteristic)
      })
  }
  
    private func peripheral(peripheral: CBPeripheral,
    didDiscoverDescriptorsForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverDescriptorsForCharacteristic")
  }
  
    private func peripheral(peripheral: CBPeripheral,
    didUpdateValueForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
      print("[PerformanceMonitor]didUpdateValueForCharacteristic: \(characteristic)")
        if let svc = Service(uuid: characteristic.service.uuid) {
            if let c = svc.characteristic(characteristic.uuid) {
            let cm = c.parse(data: characteristic.value as NSData?)
          if let pm = performanceMonitor {
            cm?.updatePerformanceMonitor(performanceMonitor: pm)
          }
        }
      }
  }
  
    private func peripheral(peripheral: CBPeripheral,
    didUpdateValueForDescriptor
    descriptor: CBDescriptor,
    error: NSError?) {
      print("[PerformanceMonitor]didUpdateValueForDescriptor")
  }
  
    private func peripheral(peripheral: CBPeripheral,
    didWriteValueForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
      print("[PerformanceMonitor]didWriteValueForCharacteristic")
  }
  
    private func peripheral(peripheral: CBPeripheral,
    didWriteValueForDescriptor
    descriptor: CBDescriptor,
    error: NSError?) {
      print("[PerformanceMonitor]didWriteValueForDescriptor")
  }
  
    private func peripheral(peripheral: CBPeripheral,
    didUpdateNotificationStateForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
      print("[PerformanceMonitor]didUpdateNotificationStateForCharacteristic")
  }
  
  // MARK: Signal Strength
    private func peripheralDidUpdateRSSI(peripheral: CBPeripheral,
    error: NSError?) {
      print("[PerformanceMonitor]didUpdateRSSI")
  }
  
  // MARK: Name
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
    print("[PerformanceMonitor]didUpdateName")
  }
}

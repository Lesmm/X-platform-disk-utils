import Foundation

@objc public class StorageUtil : NSObject {
    
    @objc
    public static func getTotalSize() -> UInt64 {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            if let totalSpace = systemAttributes[.systemSize] as? NSNumber {
                let totalSpace = totalSpace.uint64Value
                return totalSpace
            }
        } catch {
            print("Error retrieving system file attributes: \(error.localizedDescription)")
        }
        return 0
    }
    
    @objc
    public static func getAvailableSize() -> UInt64 {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            if let freeSpace = systemAttributes[.systemFreeSize] as? NSNumber {
                return freeSpace.uint64Value
            }
        } catch {
            print("Error retrieving free space: \(error.localizedDescription)")
        }
        return 0
    }
    
}

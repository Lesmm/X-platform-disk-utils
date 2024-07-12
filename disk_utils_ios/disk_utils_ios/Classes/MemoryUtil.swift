import Foundation

@objc public class MemoryUtil : NSObject {
    
    @objc
    public static func getTotalSize() -> UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
    @objc
    public static func getAvailableSize() -> UInt64 {
        let mHostPort = mach_host_self()
        var mPageSize = vm_size_t()
        var mVmInfo = vm_statistics64_data_t()
        var mCount = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.stride)
        
        host_page_size(mHostPort, &mPageSize)
        let _ = withUnsafeMutablePointer(to: &mVmInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                host_statistics64(mHostPort, HOST_VM_INFO64, $0, &mCount)
            }
        }
        
        let mFreeSize = UInt64(mVmInfo.free_count + mVmInfo.external_page_count + mVmInfo.purgeable_count - mVmInfo.speculative_count) * UInt64(mPageSize)
        return mFreeSize
    }
    
    @objc
    public static func getPssSize() -> UInt64 {
        return getAppMemorySize()
    }
    
    @objc
    public static func getAppMemorySize() -> UInt64 {
        var mVmInfo = task_vm_info()
        var mCount = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size / MemoryLayout<integer_t>.stride)
        let mKernelReturn = withUnsafeMutablePointer(to: &mVmInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &mCount)
            }
        }
        
        var mMemoryUsageInByte: UInt64 = 0
        if mKernelReturn == KERN_SUCCESS {
            mMemoryUsageInByte = mVmInfo.phys_footprint
        } else {
            print("Error with task_info(): \(String(cString: mach_error_string(mKernelReturn), encoding: .ascii) ?? "unknown error")")
        }
        return mMemoryUsageInByte
    }
    
    @objc
    public static func getResidentMemorySize() -> UInt64 {
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        
        var otherPorcessMemory: UInt64 = 0
        if kerr == KERN_SUCCESS {
            otherPorcessMemory = taskInfo.resident_size
        } else {
            print("Error on retrieve memory info: \(String(cString: mach_error_string(kerr), encoding: .ascii) ?? "unknown error")")
        }
        return otherPorcessMemory
    }
    
}

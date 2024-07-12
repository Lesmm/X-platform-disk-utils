import UIKit
import disk_utils_ios

class ViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        labelStorageSize = UILabel(frame: CGRectMake(5, 100, 400, 50))
        self.view.addSubview(labelStorageSize!)
        
        labelMemorySize = UILabel(frame: CGRectMake(5, 150, 400, 50))
        self.view.addSubview(labelMemorySize!)
        
        labelAppMemorySize = UILabel(frame: CGRectMake(5, 200, 400, 50))
        self.view.addSubview(labelAppMemorySize!)
        
        labelOtherMemorySize = UILabel(frame: CGRectMake(5, 250, 400, 50))
        self.view.addSubview(labelOtherMemorySize!)
        
        refresh()
        
        let button: UIButton = UIButton.init(type: UIButtonType.system) // UIButton(frame: CGRectMake(20, 400, 200, 100))
        button.frame = CGRectMake(5, 250, 200, 100)
        self.view.addSubview(button)
        button.addTarget(self, action:#selector(ViewController.refresh), for: UIControlEvents.touchUpInside)
        button.setTitle("Refresh", for: UIControlState.normal)
    }
    
    var labelStorageSize: UILabel? ;
    var labelMemorySize: UILabel? ;
    var labelAppMemorySize: UILabel? ;
    var labelOtherMemorySize: UILabel? ;
    
    @objc
    func refresh() {
        labelStorageSize?.text = "🍀 Disk: \(Double(StorageUtil.getTotalSize()) / 1_000_000_000.0)GB / \(Double(StorageUtil.getAvailableSize()) / 1_000_000_000.0)GB"
        labelMemorySize?.text = "🍀 Memory: \(Double(MemoryUtil.getTotalSize()) / 1_000_000_000.0)GB / \(Double(MemoryUtil.getAvailableSize()) / 1_000_000_000.0)GB"
        labelAppMemorySize?.text = "🍀 App Memory: \(Double(MemoryUtil.getAppMemorySize()) / 1_000_000.0)MB"
        labelOtherMemorySize?.text = "🍀 Resident Memory: \(Double(MemoryUtil.getResidentMemorySize()) / 1_000_000.0)MB"
    }
    
}


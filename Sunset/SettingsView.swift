import UIKit

class SettingsView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "SettingsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}

//: A UIKit based Playground for presenting user interface
  
import UIKit
//import GoLSDK

import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let myLayer = CALayer()
        myLayer.frame = CGRect(origin : .zero, size : CGSize(width : 100, height : 100))
        view.layer.addSublayer(myLayer)
        myLayer.backgroundColor = UIColor.red.cgColor
//        myLayer.anchorPoint
//        myLayer.position = view.center
        myLayer.frame = CGRect(origin : CGPoint(x:100,y:100), size : myLayer.bounds.size)
        
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

//
//  HelloFormViewController2.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class HelloFormViewController2: HelloFormViewController {

    var autoItem: UIBarButtonItem!
    var circleItem: UIBarButtonItem!
    
    var strokeColor: Color {
        return Color(UIColor(white: 0, alpha: 0.25))
//        return C4Pink.colorWithAlpha(0.25)
    }
    
    override init() {
        super.init()
        title = "Hello Form 2"
        trash = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoItem = UIBarButtonItem(title: "Auto", style: .plain, target: self, action: #selector(autoTapped))
        circleItem = UIBarButtonItem(title: "Auto (Circle)", style: .plain, target: self, action: #selector(circleTapped))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, autoItem, flexible, circleItem, flexible]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func createForm(_ circleResolution: Int, radius: Double, angle: Double) {
        let points = (0...circleResolution).map { i in
            return circlePoint(i, angle: angle, radius: radius)
        }
        let polygon = Polygon(points)
        polygon.strokeColor = strokeColor
        polygon.lineWidth = 2
        canvas.add(polygon)
    }
    
    @objc func autoTapped(_ sender: AnyObject) {
        clear()
        
        var x = nextX(canvas.width)
        let min = Double(random(in: 10..<30))
        while x > min {
            let y = Double(random(in: 84..<Int(canvas.height * 0.25)))
            drawRandom(x, y: y)
            x = nextX(x)
        }
    }
    
    @objc func circleTapped(_ sender: AnyObject) {
        clear()
        
//        var x = 10.0
//        var y = 84.0
//        let vx = 4.0
//        let vy = 2.0
//        (1...10).forEach { i in
//            x += vx * Double(i)
//            y += vy * Double(i)
//            drawRandom(x, y: positionWithNoise(y))
//        }
        
        let y = canvas.height
        let vx = 4.0
        var x = Double(random(in: 10..<50))
        (1...12).forEach { i in
            let _ = nextX(x)
            drawRandom(x, y: y)
            x += vx * Double(i)
        }
    }
    
    func drawRandom(_ x: Double, y: Double) {
        (0..<random(in: 10..<30)).forEach { _ in
            let randomX = positionWithNoise(x)
            point = Point(randomX, y)
            (0..<random(in: 1..<4)).forEach { _ in
                updateCircle()
            }
        }
    }
    
    func positionWithNoise(_ pos: Double) -> Double {
        let min = random(in: 85..<90)
        let max = random(in: 110..<115)
        return pos * Double(random(in: min..<max)) / 100.0
    }
    
    func nextX(_ x: Double) -> Double {
        let min = random(in: 55..<65)
        let max = random(in: 80..<90)
        return x * Double(random(in: min..<max)) / 100.0
    }
}

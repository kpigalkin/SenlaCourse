//
//  AnimationViewController.swift
//  TicTacToe
//
//  Created by Кирилл Пигалкин on 22.04.2022.
//

import UIKit

final class AnimationViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addAction(UIAction() { [weak self] _ in
            self?.animateView()
            }, for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    let rocketLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillRule = .evenOdd
        return shapeLayer
    }()
    
    let planetLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillRule = .evenOdd
        return shapeLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        view.backgroundColor = .systemBrown
        view.layer.addSublayer(rocketLayer)
        view.layer.addSublayer(planetLayer)
        view.addSubview(button)
        createPath()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeConstraints()
    }
}

private extension AnimationViewController {
    
    func movingAnimationToRocket(to layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = CGPoint.zero
        animation.toValue = -1000
        animation.duration = 3.0
        animation.beginTime = CACurrentMediaTime() + 0.9
        layer.add(animation, forKey: nil)
    }
    
    func movingAnimationToPlanet(to layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = CGPoint.zero
        animation.toValue = view.frame.maxY
        animation.duration = 3.0
        animation.beginTime = CACurrentMediaTime() + 0.9
        layer.add(animation, forKey: nil)
    }
    
    func animationOfShakingToRocket(to layer: CAShapeLayer) {
        let animation = CASpringAnimation(keyPath: "position")
        let fromValue = NSValue(cgPoint: CGPoint(x: layer.frame.midX - 5, y: layer.frame.midY))
        let toValue = NSValue(cgPoint: CGPoint(x: layer.frame.midX + 5, y: layer.frame.midY))
        animation.duration = 0.1
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = fromValue
        animation.toValue = toValue
        layer.add(animation, forKey: nil)
    }
    func shrinkAnimationToRocket(to layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 0
        animation.autoreverses = true
        animation.duration = 2.0
        animation.beginTime = CACurrentMediaTime() + 0.9
        layer.add(animation, forKey: nil)
    }
    
    func animateView() {
        shrinkAnimationToRocket(to: rocketLayer)
        animationOfShakingToRocket(to: rocketLayer)
        movingAnimationToRocket(to: rocketLayer)
        movingAnimationToPlanet(to: planetLayer)
    }
    
    func createPath() {
        
        // Rocket
        let path = UIBezierPath()
        let startedPoint = CGPoint(
            x: view.frame.midX,
            y: view.frame.midY + view.frame.midY * 2/5)
        let secondPoint = CGPoint(
            x: startedPoint.x - 20,
            y: startedPoint.y + 80)
        let thirdPoint = CGPoint(
            x: secondPoint.x - 10,
            y: secondPoint.y + 20)
        let fourthPoint = CGPoint(
            x: thirdPoint.x + 5,
            y: thirdPoint.y + 25)
        let fifthPoint = CGPoint(
            x: fourthPoint.x + 6,
            y: fourthPoint.y)
        let sixthPoint = CGPoint(
            x: fifthPoint.x + 7,
            y: fifthPoint.y - 19)
        
        let mirrorSixthPoint = CGPoint(
            x: sixthPoint.x + 2 * (startedPoint.x - sixthPoint.x),
            y: sixthPoint.y)
        let mirrorFifthPoint = CGPoint(
            x: fifthPoint.x + 2 * (startedPoint.x - fifthPoint.x),
            y: fifthPoint.y)
        let mirrorFourthPoint = CGPoint(
            x: fourthPoint.x + 2 * (startedPoint.x - fourthPoint.x),
            y: fourthPoint.y)
        let mirrorThirdPoint = CGPoint(
            x: thirdPoint.x + 2 * (startedPoint.x - thirdPoint.x),
            y: thirdPoint.y)
        let mirrorSecondPoint = CGPoint(
            x: secondPoint.x + 2 * (startedPoint.x - secondPoint.x),
            y: secondPoint.y)
        
        let windowPoint = CGPoint(
            x: startedPoint.x,
            y: startedPoint.y + 40)
        
        // Rocket
        path.move(to:startedPoint)
        path.addCurve(
            to: secondPoint,
            controlPoint1: CGPoint(x: secondPoint.x - 9, y: startedPoint.y + 20),
            controlPoint2: CGPoint(x: secondPoint.x - 9, y: secondPoint.y - 15)
        )
        path.addLine(to: thirdPoint)
        path.addLine(to: fourthPoint)
        path.addLine(to: fifthPoint)
        path.addLine(to: sixthPoint)
        path.addLine(to: mirrorSixthPoint)
        path.addLine(to: mirrorFifthPoint)
        path.addLine(to: mirrorFourthPoint)
        path.addLine(to: mirrorThirdPoint)
        path.addLine(to: mirrorSecondPoint)
        path.move(to:startedPoint)
        path.addCurve(
            to: mirrorSecondPoint,
            controlPoint1: CGPoint(x: mirrorSecondPoint.x + 9, y: startedPoint.y + 20),
            controlPoint2: CGPoint(x: mirrorSecondPoint.x + 9, y: mirrorSecondPoint.y - 15)
        )
        // Window
        path.move(to: CGPoint(x: windowPoint.x + 9, y: windowPoint.y))
        path.addArc(withCenter: windowPoint, radius: 9, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        path.lineWidth = 5
        rocketLayer.path = path.cgPath
        
        // Planet
        let marsPath = UIBezierPath()
        let startPoint = CGPoint(
            x: view.frame.minX - 100,
            y: view.frame.maxY)
        let endPoint = CGPoint(
            x: view.frame.maxX + 100,
            y: view.frame.maxY)
        marsPath.move(to: startPoint)
        marsPath.addCurve(
            to: endPoint,
            controlPoint1: CGPoint(
                x: fourthPoint.x - 300,
                y: fourthPoint.y - 50),
            controlPoint2: CGPoint(
                x: mirrorFourthPoint.x + 300,
                y: mirrorFourthPoint.y - 50))
        marsPath.lineWidth = 10
        planetLayer.path = marsPath.cgPath
    }
    
    func makeConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
